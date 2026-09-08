# Testing

## Behavior specification

For features, bug fixes, and refactors, write or identify the test that specifies the expected behavior before implementation. Verify the result against explicit success criteria. If a test cannot be written first, state what should be tested and why it cannot be done first.

## Directory layout

Follow the repository's established test location and naming convention. When tests live in a separate tree, mirror source paths unless the repository specifies another structure.

## Test boundaries

- Test inner business behavior directly with values and explicit expected results.
- Test outer integrations at their actual boundaries.
- Simple forwarding adapters need no dedicated tests unless the adaptation carries meaningful behavioral or integration risk.
- Test async adapters when they define cancellation, cleanup, timeout, late-callback, or error-channel semantics. Verify cancellation cleanup runs when cancelled but not after normal completion.
- Exercise synchronous exceptions while acquiring or constructing an async operation as well as its later asynchronous failures; the two may follow different error paths.
- When a library cannot run correctly under the test runtime, diagnose the runtime mismatch and test it in a compatible integration environment rather than reproducing library behavior in production code.
- Use fakes, stubs, injected functions, or native test facilities when they fit an existing boundary.
- Keep the production operation under test visible in the test body that exercises it. Shared test support may construct external dependencies, but should not invoke or wrap the system under test.
- Keep simple scenario values and one-off setup in the test; extract only reusable dependency construction that clarifies the boundary.
- Preserve existing meaningful test seams; see `architecture.md` for interface rules.
- Cover successful behavior, relevant failures, edge cases, and idempotency where applicable.
