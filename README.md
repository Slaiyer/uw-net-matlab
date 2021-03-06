Entry point
===========

- `optim_config_node(inCSV, iters, verbose)`

Input
-----

1. _inCSV_: Path to CSV file with node radii

2. _iters_ (Optional)

    - Default: 1

    - Number of times `stretch_chainlink` is called with the same _R_

3. _verbose_ (Optional)

    - Default: false

    - Controls the verbosity of `optim_config_node` and `stretch_chainlink`

Output
------

1. Best node configuration: _inCSV_`-optim_node_config.csv`

2. Maximal volume achieved: _inCSV_`-optim_vol.txt`

Example
=======

```
#!matlab
optim_node_config('test_radii.csv', 4, true)
```

Documentation
=============

- MATLAB-generated documentation from the source code is in the **html** directory.

- After cloning this repository into MATLAB's path, use one of the following at its command line:

    - `help optim_node_config`

    - `help stretch_chainlink`

    - `help chainlink`

    - `help attenuate`

    - `help node_config_vol`

*[CSV]: Comma-separated values
