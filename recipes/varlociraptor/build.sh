#!/bin/bash -euo

# Add workaround for SSH-based Git connections from Rust/cargo.  See https://github.com/rust-lang/cargo/issues/2078 for details.
# We set CARGO_HOME because we don't pass on HOME to conda-build, thus rendering the default "${HOME}/.cargo" defunct.
export CARGO_NET_GIT_FETCH_WITH_CLI=true CARGO_HOME="$(pwd)/.cargo"
# Make sure bindgen passes on our compiler flags.
export BINDGEN_EXTRA_CLANG_ARGS="${CPPFLAGS} ${CFLAGS} ${LDFLAGS}"

# Use -Cembed-bitcode=yes until https://github.com/rust-lang/cargo/pull/8754 is in a new Cargo release.
RUSTFLAGS="${RUSTFLAGS-} -Cembed-bitcode=yes" \
cargo install --path . --root $PREFIX --verbose
