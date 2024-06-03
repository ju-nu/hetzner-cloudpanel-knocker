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

4. Make the `run.sh` script executable:
   ```sh
   chmod +x run.sh
   ```

## Configuration

Create a `.env` file in the root directory of your project and populate it with your configuration details. An example `.env` file is shown below:

```
# Environment variables for the PHP firewall management script

# The expected knock key for authentication
EXPECTED_KNOCK_KEY=your_knock_key

# The name of the script to be executed
RUN_NAME=run.sh

# Hetzner API token
API_TOKEN=your_api_token

# Firewall ID in Hetzner Cloud
FIREWALL_ID=your_firewall_id
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
