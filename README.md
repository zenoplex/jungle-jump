<a name="top"></a>

<div align="center">
  <h3 align="center">Jungle Jump</h3>

  <p align="center">
    Arcade classic with physics
  </p>
</div>

## About The Project

![Project Screen Shot][project-screenshot]

Based from [Godot 4 Game Development Projects - Second Edition][Godot-book] by Chris Bradfield

Learning 2D arcade classic with physics.

- Physics using [CharacterBody2D](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html)
- [Collision Layers and Masks](https://docs.godotengine.org/en/stable/tutorials/physics/physics_introduction.html#doc-physics-introduction-collision-layers-and-masks)
- Creating levels with [TileMap](https://docs.godotengine.org/en/stable/classes/class_tilemap.html) and [TileSet](https://docs.godotengine.org/en/stable/classes/class_tileset.html#class-tileset)

### Built With

- [![Godot][Godot-shield]][Godot]

## Getting Started

Below is instructions on setting up your project locally on MacOS.
To get a local copy up and running follow these simple steps.

### Prerequisites

- Install godot
  ```bash
  # install godot
  brew install godot --cask
  ```
- (Optional) Use VSCode for external editor
- (Optional) Install [Godot tools][Godot-tools] and connect with Godot Editor

### Installation

1. Checkout the repository
1. Open (import) project via Project Manager
1. Customize as you like
1. Run project (`cmd + B`)

## Roadmap

- [x] Add base game
- [x] Add static types
- [x] Add score
- [ ] Refactor
  - [ ] Define default parameters to global
- [ ] Customize
  - [ ] Add more levels
  - [ ] Add clear scene

## License

Distributed under the MIT License.

<p align="right"><a href="#top">↑ Back to top</a></p>

[project-screenshot]: ./screenshot.gif
[Godot]: https://godotengine.org
[Godot-shield]: https://img.shields.io/badge/Godot-v4.2-%23478cbf?logo=godot-engine&logoColor=white
[Godot-tools]: https://marketplace.visualstudio.com/items?itemName=geequlim.godot-tools
[Godot-book]: https://www.oreilly.com/library/view/godot-4-game/9781804610404/?_gl=1*17odie3*_ga*MTI0NTI3MjkwOC4xNzA0NDYyMDg4*_ga_092EL089CH*MTcwNDQ2MjA4OC4xLjEuMTcwNDQ2MjExMS4zNy4wLjA.
