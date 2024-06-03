   # PHP Firewall Management Script

   This project contains a PHP script and a shell script to manage firewall rules using the Hetzner Cloud API.

   ## Requirements

   - PHP 7.4+
   - Composer
   - cURL
   - jq

   ## Installation

   1. Clone the repository:
      ```sh
      git clone https://github.com/your-username/my_project.git
      cd my_project
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
