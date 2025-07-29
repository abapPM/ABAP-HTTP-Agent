![Version](https://img.shields.io/endpoint?url=https://shield.abappm.com/github/abapPM/ABAP-HTTP-Agent/src/%23apmg%23if_http_agent.intf.abap/c_version&label=Version&color=blue)

[![License](https://img.shields.io/github/license/abapPM/ABAP-HTTP-Agent?label=License&color=success)](https://github.com/abapPM/ABAP-HTTP-Agent/blob/main/LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg?color=success)](https://github.com/abapPM/.github/blob/main/CODE_OF_CONDUCT.md)
[![REUSE Status](https://api.reuse.software/badge/github.com/abapPM/ABAP-HTTP-Agent)](https://api.reuse.software/info/github.com/abapPM/ABAP-HTTP-Agent)

# HTTP Agent

Easy to use HTTP agent and login manager with request/response handling.

NO WARRANTIES, [MIT License](https://github.com/abapPM/ABAP-HTTP-Agent/blob/main/LICENSE)

## Usage

Initialize an HTTP agent and set header fields:

```abap
DATA(agent) = /apmg/cl_http_agent=>create( ).

" Optionally set headers
agent->global_headers( )->set(
  iv_key = /apmg/if_http_agent=>c_header-accept
  iv_val = /apmg/if_http_agent=>c_content_type-json ).

agent->global_headers( )->set(
  iv_key = /apmg/if_http_agent=>c_header-content_type
  iv_val = /apmg/if_http_agent=>c_content_type-json ).

agent->global_headers( )->set(
  iv_key = /apmg/if_http_agent=>c_header-user_agent
  iv_val = `abap 7.5` ).
```

Get and set authorization tokens:

```abap
DATA(host) = 'api.github.com'.

IF /apmg/cl_http_login_manager=>get( host ) IS NOT INITIAL.
  agent->global_headers( )->set(
    iv_key = /apmg/if_http_agent=>c_header-authorization
    iv_val = /apmg/cl_http_login_manager=>get( host ) ).
ENDIF.
```

Get request:

```abap
DATA(response) = agent->request( url = 'https://api.github.com/emojis' ).

IF response->is_ok( ) = abap_false.
  message = |Error { response->code( ) }|.
ENDIF.
```

Put request with payload:

```abap
DATA(response) = agent->request(
  url     = 'https://myserver.com/'
  method  = /apmg/if_abappm_http_agent=>c_method-put
  payload = json ).

IF response->is_ok( ) = abap_false.
  message = |Error { response->code( ) }|.
ENDIF.
```

## Prerequisites

SAP Basis 7.50 or higher

## Installation

Install `http-agent` as a global module in your system using [apm](https://abappm.com).

or

Specify the `http-agent` module as a dependency in your project and import it to your namespace using [apm](https://abappm.com).

## Contributions

All contributions are welcome! Read our [Contribution Guidelines](https://github.com/abapPM/ABAP-HTTP-Agent/blob/main/CONTRIBUTING.md), fork this repo, and create a pull request.

You can install the developer version of ABAP HTTP Agent using [abapGit](https://github.com/abapGit/abapGit) either by creating a new online repository for `https://github.com/abapPM/ABAP-HTTP-Agent`.

Recommended SAP package: `/APMG/HTTP-AGENT`

## About

Made with ❤ in Canada

Copyright 2025 apm.to Inc. <https://apm.to>

Follow [@marcf.be](https://bsky.app/profile/marcf.be) on Blueksy and [@marcfbe](https://linkedin.com/in/marcfbe) or LinkedIn
