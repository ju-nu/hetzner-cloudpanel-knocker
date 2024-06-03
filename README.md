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

## Termius Configuration

To automate running the PHP script before connecting to your server using Termius, follow these steps:

1. **Open Termius**:
   - Open Termius and navigate to the host you want to configure.
   - Click on the host to edit its settings.

2. **Configure Pre-Connection Script**:
   - Go to the **SFT/Local** tab.
   - Under the **Local Before Connect Script** section, click on **Inline Script**.
   - Enter the following script:
     ```sh
     curl -s "http://localhost:8000/index.php?knock=YOUR_KNOCK_KEY"
     sleep 5
     ```
   - Replace `YOUR_KNOCK_KEY` with your actual knock key.
   - Save the settings.

When you connect to your server using Termius, it will automatically run the inline script, wait for 5 seconds, and then connect to the server. This delay ensures that the firewall rules have enough time to update before the connection is attempted.

## License

This project is licensed under the MIT License.
