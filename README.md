# Seia-Soto/v-ohys

The Ohys-API support for V lang.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [LICENSE](#license)

----

# Installation

This module is not available from vpm, so you need to clone this repository instead: `git clone https://github.com/Seia-Soto/v-ohys ohys_api`

# Usage

Here is an example usage of this module.

```vlang
import ohys_api

fn main() {
  data := ohys_api.get_feed(0)

  println(ohys_api.parse_title(data[0].name))
}
```

# LICENSE

This repository is distributed under [MIT License](/LICENSE).
