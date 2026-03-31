FROM rust:1-slim-bookworm AS builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /app/target/release/shrink /usr/local/bin/shrink
COPY static/ /app/static/
EXPOSE 3000
ENV HOST=0.0.0.0
CMD ["shrink"]
