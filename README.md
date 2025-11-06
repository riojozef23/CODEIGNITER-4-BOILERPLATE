# 🚀 CodeIgniter 4 QuickStart Boilerplate (Dockerized)

Clone this boilerplate and set up your **CodeIgniter 4 (CI4)** development environment in minutes — just using Docker!

This boilerplate comes fully integrated with **Nginx** and **PHP-FPM**, so you can focus on writing code instead of configuring infrastructure.

---

## ✨ Key Features

- ✅ **Instant Setup** — Start coding immediately with one command (`make start`).
- 🐳 **Fully Containerized** — Includes Nginx & PHP-FPM, ready for development.
- ⚡ **CodeIgniter 4.6.3** — The latest stable release.
- 🛠️ **Simple Tooling** — Manage everything easily with the provided `Makefile`.
- 📦 **Clean Structure** — Clear separation between app source code and server configuration.

---

## ⚙️ Requirements

Make sure you have the following installed:

1. [Git](https://git-scm.com/) (To clone the repository)
2. [Docker](https://www.docker.com/)
3. Docker Compose (usually included with modern Docker installations)
4. **Make** (Utility for simple commands):
    * **Linux/macOS:** Often pre-installed or available via `build-essential` (Linux).
    * **Windows:** The `make` commands should be executed via **Git Bash** or a similar shell environment, as `make` is not native to CMD/PowerShell.

---

## 🏎️ Quick Start Guide

### 1️⃣ Clone the Repository & Set Up Environment

```bash
# Clone the repository
git clone git@github.com:riojozef23/CODEIGNITER-4-BOILERPLATE.git
cd CODEIGNITER-4-BOILERPLATE

# Copy environment file
cp .env.example .env
```

> 💡 **Note:** Edit `src/.env` to match your database configuration.

---

### 2️⃣ Build & Run the Services

Use the `Makefile` for a quick automated setup:

```bash
make build
```

This will build the Docker image (if not already built) and start all containers in the background.

> 💡 **Alternative Methods**: If you do not have the make utility installed on your system (common on non-standard Windows/Linux setups), you can use the following commands directly:

- Using the Bash Script (Requires Bash Shell):

```bash
./sh/build.sh
```
- Using Direct Docker Compose (Most Universal):
```bash
docker compose up --build -d (The -d flag runs the containers in detached mode, similar to the make build command.)
```


Using the Bash Script (Requires Bash Shell):
---

### 3️⃣ Access the Application

Once the containers are running, open your browser and visit:

```
http://localhost:8000
```

> Check your `docker-compose.yml` file if a different port is configured.

---

## 🔧 Makefile Commands

The `Makefile` simplifies Docker interactions.  
Use the following commands to manage your environment:

| Command | Function | Description |
|----------|-----------|-------------|
| `make help` | Help | Show all available commands. |
| `make build` | Build & Start | Rebuild Docker images and start all services. |
| `make start` | Quick Start | Run existing containers in detached mode. |
| `make stop` | Stop Services | Stop and remove all running containers. |
| `make healthcheck` | Health Check | Verify the health of all running containers. |
| `make purge` | Full Cleanup | Remove all containers, images, volumes, and networks (⚠️ This will delete all related data). |

---

### 💻 Example Usage

```bash
# Initial setup
make build

# Continue development
make start

# Stop services
make stop
```

---

## 📁 Project Structure

```
.
├── conf/               # Nginx & PHP-FPM configuration
├── sh/                 # Bash scripts (start.sh, build.sh, etc.)
├── src/                # CodeIgniter 4 application
├── docker-compose.yml  # Docker services definition
├── .env.example        # Docker environment example file
├── Makefile            # Quick automation commands
└── README.md           # Project documentation
```

---

## 🧠 Additional Tips

- Use `make purge` only when you want to completely reset everything.
- The `.env` file inside `src/app_ci` belongs to **CodeIgniter**, not Docker Compose.
- To add custom PHP extensions, edit `conf/php-fpm/Dockerfile`.

---
## 🪪 License

This project is licensed under the [MIT License](LICENSE).

---

👨‍💻 **Developed by:** [@riojozef23](https://github.com/riojozef23)  
📧 **Contact:** riostefanus@gmail.com