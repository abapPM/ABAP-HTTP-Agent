INTERFACE zif_http_response PUBLIC.

************************************************************************
* HTTP Response
*
* Copyright (c) 2014 abapGit Contributors
* SPDX-License-Identifier: MIT
************************************************************************
  METHODS data
    RETURNING
      VALUE(rv_data) TYPE xstring.

  METHODS cdata
    RETURNING
      VALUE(rv_data) TYPE string.

  METHODS json
    RETURNING
      VALUE(ri_json) TYPE REF TO zif_ajson
    RAISING
      zcx_error.

  METHODS is_ok
    RETURNING
      VALUE(rv_yes) TYPE abap_bool.

  METHODS code
    RETURNING
      VALUE(rv_code) TYPE i.

  METHODS error
    RETURNING
      VALUE(rv_message) TYPE string.

  METHODS headers
    RETURNING
      VALUE(ro_headers) TYPE REF TO zcl_abap_string_map
    RAISING
      zcx_error.

  METHODS close.

ENDINTERFACE.
