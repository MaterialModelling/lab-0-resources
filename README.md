# Lab: Materials Modelling at the Continuum Scale

**Module: Materialmodellierung | Helmut-Schmidt-Universität Hamburg**

This repository contains the Jupyter notebook and Docker environment for the continuum-scale modelling lab. Students solve two PDE problems using the Finite Element Method (FEM) via the [FEniCS](https://fenicsproject.org/) library.

## Contents

| File | Description |
|---|---|
| `continuum_lab.ipynb` | Lab notebook (Poisson + Cahn-Hilliard) |
| `Dockerfile` | Self-contained FEniCS + Jupyter environment |

## Lab Overview

### Part 1 — Poisson Equation (Elastic Membrane)

Solve $-\nabla^2 u = g$ on the unit square with homogeneous Dirichlet boundary conditions. The same equation governs heat conduction, diffusion, and electrostatics — only the physical interpretation changes.

Students explore uniform and localised load distributions and verify mesh convergence.

### Part 2 — Cahn-Hilliard Phase Field Model (Spinodal Decomposition)

Simulate the spontaneous unmixing of a binary alloy using the Cahn-Hilliard equation:

$$\frac{\partial n}{\partial t} = \nabla^2\!\left(\frac{\partial G}{\partial n} - \kappa\nabla^2 n\right)$$

Students observe how the interface energy parameter $\kappa$ controls microstructure length scale and how initial composition affects phase morphology (interconnected network vs. isolated droplets).

## Getting Started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (no local Python/FEniCS installation required)

### Build the image

```bash
docker build -t matmod-continuum .
```

This installs legacy FEniCS (`dolfin`), Jupyter, matplotlib, scipy, and ipywidgets via conda-forge. Build takes a few minutes the first time.

### Launch Jupyter

```bash
docker run -p 8888:8888 -v "$(pwd)":/work matmod-continuum
```

Then open **http://localhost:8888** in your browser (no password).

Open `continuum_lab.ipynb` and work through the cells top to bottom with **Shift + Enter**.

## Notes for Students

- Cells marked `# ACTION` contain parameters you should change and experiment with.
- FEniCS may print initialisation messages on first run — this is normal.
- Add your observations as markdown cells below each experiment (*Insert → Insert Cell Below*, then set type to Markdown).
- If the Cahn-Hilliard solver fails to converge, reduce `dt` (e.g. from `1e-4` to `5e-5`).

## Software Stack

| Package | Role |
|---|---|
| FEniCS (legacy dolfin) | FEM assembly and nonlinear solver |
| Jupyter Notebook | Interactive lab environment |
| matplotlib | Visualisation |
| NumPy / SciPy | Numerical utilities |

The `quay.io/fenicsproject` images are no longer maintained; this Dockerfile uses `condaforge/mambaforge` with the `fenics` package from conda-forge, which keeps `from dolfin import *` working without any notebook changes.
