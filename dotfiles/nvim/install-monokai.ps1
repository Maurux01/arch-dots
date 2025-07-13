# PowerShell script to install and configure Monokai Pro theme for Neovim

Write-Host "🎨 Installing Monokai Pro theme for Neovim..." -ForegroundColor Green

# Check if Neovim is installed
if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Neovim is not installed. Please install Neovim first." -ForegroundColor Red
    exit 1
}

# Create config directory if it doesn't exist
$CONFIG_DIR = "$env:USERPROFILE\.config\nvim"
if (-not (Test-Path $CONFIG_DIR)) {
    Write-Host "📁 Creating Neovim config directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $CONFIG_DIR -Force | Out-Null
}

# Copy dotfiles to config directory
Write-Host "📋 Copying Neovim configuration..." -ForegroundColor Yellow
Copy-Item -Path "dotfiles\nvim\*" -Destination $CONFIG_DIR -Recurse -Force

# Install Neovim configuration
Write-Host "⚙️ Installing Neovim configuration..." -ForegroundColor Yellow
Set-Location $CONFIG_DIR
if (Test-Path "install.sh") {
    # If you have Git Bash or WSL available
    if (Get-Command bash -ErrorAction SilentlyContinue) {
        bash install.sh
    } else {
        Write-Host "⚠️ Please run the install.sh script manually in Git Bash or WSL" -ForegroundColor Yellow
    }
}

Write-Host "✅ Monokai Pro theme installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "🎯 To use Monokai Pro theme:" -ForegroundColor Cyan
Write-Host "   1. Open Neovim: nvim" -ForegroundColor White
Write-Host "   2. Switch to Monokai Pro: :colorscheme monokai-pro" -ForegroundColor White
Write-Host "   3. Or use the theme switcher: <leader> + t" -ForegroundColor White
Write-Host ""
Write-Host "🔄 Available themes:" -ForegroundColor Cyan
Write-Host "   - tokyonight (default)" -ForegroundColor White
Write-Host "   - catppuccin" -ForegroundColor White
Write-Host "   - gruvbox" -ForegroundColor White
Write-Host "   - dracula" -ForegroundColor White
Write-Host "   - habamax" -ForegroundColor White
Write-Host "   - monokai-pro (NEW!)" -ForegroundColor Green
Write-Host ""
Write-Host "💡 Tip: Use the theme switcher to cycle through themes quickly!" -ForegroundColor Cyan 