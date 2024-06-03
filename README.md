# CloudPanel + Hetzner Cloud Firewall Knocking Script

This project contains a PHP script and a shell script to manage firewall rules using the Hetzner Cloud API. The script is designed to be used in combination with CloudPanel to dynamically update firewall rules based on client IP addresses.

## Requirements

- PHP 7.4+
- Composer
- cURL
- jq

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/ju-nu/hetzner-cloudpanel-knocker.git
   cd hetzner-cloudpanel-knocker
   ```

2. Install Composer dependencies:
   ```sh
   composer install
   ```

3. Copy the `.env.example` file to `.env` and update the variables:
   ```sh
   cp .env.example .env
   nano .env
   ```

## Configuration

Create a `.env` file in the root directory of your project and populate it with your configuration details. An example `.env` file is shown below:

```
# Environment variables for the PHP firewall management script

# The expected knock key for authentication
EXPECTED_KNOCK_KEY=your_knock_key

# The name of the script to be executed
SCRIPT_NAME=run.sh

# Hetzner API token
API_TOKEN=your_api_token

# Firewall ID in Hetzner Cloud
FIREWALL_ID=your_firewall_id

# Port to be opened for the client's IP address
PORT=8443

# Ports to be opened for all IP addresses
PORTS=80,443

# IPv4 address range (0.0.0.0/0 allows all IPv4 addresses)
IPV4=0.0.0.0/0

# IPv6 address range (::/0 allows all IPv6 addresses)
IPV6=::/0
```

Replace `your_knock_key`, `your_api_token`, and `your_firewall_id` with your actual values.

## Usage

1. Start the PHP server:
   ```sh
   php -S localhost:8000
   ```

2. Access the script in your browser:
   ```
   http://localhost:8000/index.php?knock=YOUR_KNOCK_KEY
   ```

The PHP script will execute the `run.sh` script with the client's IP address as a parameter.

## License

This project is licensed under the MIT License.
```

### Final Steps

1. **Ensure you have Composer installed** to manage the PHP dependencies.

2. **Start the PHP server** as shown in the usage section of the README.

3. **Make sure the `.env` file** is properly configured with your actual values.

By following these steps and using this `README.md`, you can set up and run your PHP script to manage firewall rules dynamically with Hetzner Cloud API and use it in combination with CloudPanel.
