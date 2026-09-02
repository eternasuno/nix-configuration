# Architecture

Prefer a simple two-layer boundary:

```text
outer layer → inner layer
```

## Inner layer

The inner layer contains domain data, validation, decisions, and business transformations.

- Prefer pure functions with explicit inputs and outputs.
- Do not import frameworks, SDKs, databases, networks, filesystems, process state, or outer-layer implementations.
- Return domain values or failures.
- Do not return UI, CLI, transport, framework, or infrastructure commands unless that is an explicit design requirement.
- Keep business decisions out of adapters and entry points.

## Outer layer

The outer layer contains entry points and interactions with the outside world:

- HTTP, CLI, message listeners, databases, files, queues, processes, and external services;
- framework bootstrap, configuration, serialization, and concrete implementations;
- translation between external representations and inner-layer values.

The outer layer invokes inner functions and performs the required effects. Keep adapters thin: perform only the mechanism conversion needed between an external capability and inner code. Keep business policy and decisions in the inner layer.

## Interfaces

Use an interface only when the design explicitly requires one for a stable boundary, dependency inversion, multiple implementations, or a deliberate test seam.

- Define the interface at the inner boundary when inner code must depend on an outer capability.
- Implement it in the outer layer.
- Do not introduce an interface or inject a stable platform function solely for mocking or hypothetical replacement.
- Use a capability interface when the same operation requires materially different implementations across target runtimes.
- When no interface is explicitly designed, use the smallest concrete function, type, or dependency that respects the boundary.

## Dependency rule

Dependencies point inward. Inner code may be used by outer code; inner code must not depend on outer code or outer technology.

Start with the two layers. Split them into more modules or packages only when ownership, deployment, technology, or size creates a real boundary.
