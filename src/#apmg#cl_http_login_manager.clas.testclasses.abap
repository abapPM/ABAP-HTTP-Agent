CLASS ltcl_login_manager DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.

  PRIVATE SECTION.
    CONSTANTS:
      c_username TYPE string VALUE 'Aladdin',
      c_password TYPE string VALUE 'OpenSesame',
      c_token    TYPE string VALUE 'TestToken'.

    METHODS:
      setup,
      teardown,
      basic_auth FOR TESTING RAISING /apmg/cx_error,
      bearer_auth FOR TESTING RAISING /apmg/cx_error,
      save FOR TESTING RAISING /apmg/cx_error,
      same_server FOR TESTING RAISING /apmg/cx_error.

ENDCLASS.

CLASS ltcl_login_manager IMPLEMENTATION.

  METHOD setup.
    /apmg/cl_http_login_manager=>clear( ).
  ENDMETHOD.

  METHOD teardown.
    /apmg/cl_http_login_manager=>clear( ).
  ENDMETHOD.

  METHOD save.

    CONSTANTS c_host TYPE string VALUE 'https://abapgit.org/foo/bar'.
    CONSTANTS c_auth TYPE string VALUE 'foobar'.

    /apmg/cl_http_login_manager=>save(
      host = c_host
      auth = c_auth ).

    cl_abap_unit_assert=>assert_equals(
      act = /apmg/cl_http_login_manager=>get( c_host )
      exp = c_auth ).

  ENDMETHOD.

  METHOD basic_auth.

    DATA(auth) = /apmg/cl_http_login_manager=>set(
      host     = 'https://github.com/abapGit/abapGit.git'
      username = c_username
      password = c_password
      is_basic = abap_true ).

    cl_abap_unit_assert=>assert_equals(
      act = auth
      exp = 'Basic QWxhZGRpbjpPcGVuU2VzYW1l' ).

  ENDMETHOD.

  METHOD bearer_auth.

    DATA(auth) = /apmg/cl_http_login_manager=>set(
      host     = 'https://github.com/abapGit/abapGit.git'
      username = c_username
      password = c_token
      is_basic = abap_false ).

    cl_abap_unit_assert=>assert_equals(
      act = auth
      exp = |Bearer { c_token }| ).

  ENDMETHOD.

  METHOD same_server.

    CONSTANTS: c_github1 TYPE string VALUE 'https://github.com/abapGit/abapGit.git',
               c_github2 TYPE string VALUE 'https://github.com/larshp/Foobar.git'.

    /apmg/cl_http_login_manager=>set(
      host     = c_github1
      username = c_username
      password = c_password ).

    DATA(auth1) = /apmg/cl_http_login_manager=>get( c_github1 ).
    DATA(auth2) = /apmg/cl_http_login_manager=>get( c_github2 ).

    cl_abap_unit_assert=>assert_equals(
      act = auth1
      exp = auth2 ).

  ENDMETHOD.

ENDCLASS.
