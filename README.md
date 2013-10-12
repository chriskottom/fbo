# FBO

Fetch a dated dump file from [FedBizOpps](https://www.fbo.gov) and parse its
contents into structures suitable for use by other programs.

The gem in its current state handles most of the notice types described in the
[FBO documentation](https://www.fbo.gov/?&static=interface) for the data format.
* Presolicitation (PRESOL)
* Combined Synopsis/Solicitation (COMBINE)
* Amendment to a Previous Combined Solicitation (AMDCSS)
* Modification to a Previous Base (MOD)
* Award (AWARD)
* Justification and Approval (JA)
* Intent to Bundle Requirements (ITB)
* Fair Opportunity / Limited Sources Justification (FAIROPP)
* Sources Sought (SRCSGT)
* Foreign Government Standard (FSTD)
* Special Notice (SNOTE)
* Sale of Surplus Property (SSALE)
* Document Archival (ARCHIVE)
* Document Unarchival (UNARCHIVE)

Two notice types have not yet been implemented as no record of their ever having
been used could be found in any of the FBO dump files dating back as far as 2001.
These are:
* Document Upload (EPSUPLOAD)
* Document Deleting (DELETE)


## Installation

Add this line to your application's Gemfile:

    gem 'fbo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fbo

## Usage

The gem provides a number of 



## Contributing

Code contributions gratefully accepted.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Logging any issues you might notice at the
[Issues tracker](https://github.com/chriskottom/fbo/issues)
on GitHub is also a great way to help out.
