# easy-acmesh

Easily issue TLS certificates with [`acme.sh`](https://github.com/acmesh-official/acme.sh) in Docker.

## Usage

1. Create an env file named `.env`:

   ```sh
   # e.g.
   CF_Token="YOUR_TOKEN"
   ```

2. Create output directory `volumes/acme.sh`:

   ```sh
   mkdir -p volumes/acme.sh
   ```

3. Start acme.sh container:

   ```sh
   docker-compose up -d
   ```

4. Register ZeroSSL account:

   ```sh
   docker exec acme.sh --register-account -m '<YOUR_EMAIL>'
   ```

5. Issue certificates:

   ```sh
   docker exec acme.sh --issue --dns dns_cf -d '<YOUR_DOMAIN_NAME_1>' -d '<YOUR_DOMAIN_NAME_2>'
   ```

   Issued certificates will be saved to `volumes/acme.sh/<YOUR_DOMAIN_NAME>_ecc`

## License

[MIT](./LICENSE) License &copy; 2025-PRESENT [mys1024](https://github.com/mys1024)
