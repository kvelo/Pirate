# Open the dedicated Chrome window on Windows display 2.
$ErrorActionPreference = 'Stop'
try {
    Add-Type -AssemblyName System.Windows.Forms
    $screen = [System.Windows.Forms.Screen]::AllScreens |
        Where-Object { $_.DeviceName -eq '\\.\DISPLAY2' } |
        Select-Object -First 1
    if (-not $screen) {
        throw 'Ecran 2 (DISPLAY2) introuvable. Activez le mode Etendre dans les parametres Windows.'
    }
    Add-Type @'
using System;
using System.Runtime.InteropServices;
public static class PirateWindow {
    [DllImport("user32.dll", SetLastError=true)]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr after,
        int x, int y, int width, int height, uint flags);
}
'@
    $bounds = $screen.Bounds
    $profile = $env:PIRATE_CHROME_PROFILE
    $chrome = $env:PIRATE_CHROME_EXE
    if (-not $profile -or -not $chrome) { throw 'Lancez ce fichier via Lancer-PIRATE.bat.' }
    $arguments = @(
        ('--user-data-dir="' + $profile + '"'),
        '--no-first-run', '--no-default-browser-check',
        "--window-position=$($bounds.X),$($bounds.Y)",
        "--window-size=$($bounds.Width),$($bounds.Height)",
        '--kiosk', '--new-window', 'http://127.0.0.1:5173/'
    )
    Start-Process -FilePath $chrome -ArgumentList $arguments | Out-Null
    $window = $null
    for ($i = 0; $i -lt 60; $i++) {
        $candidates = Get-CimInstance Win32_Process -Filter "Name = 'chrome.exe'" |
            Where-Object { $_.CommandLine -and $_.CommandLine.Contains($profile) -and $_.CommandLine -notmatch '--type=' }
        foreach ($candidate in $candidates) {
            $process = Get-Process -Id $candidate.ProcessId -ErrorAction SilentlyContinue
            if ($process -and $process.MainWindowHandle -ne [IntPtr]::Zero) {
                $window = $process.MainWindowHandle
                break
            }
        }
        if ($window) { break }
        Start-Sleep -Milliseconds 250
    }
    if (-not $window) { throw 'La fenetre Chrome est introuvable.' }
    # Move the kiosk window explicitly, including displays with negative coordinates.
    if (-not [PirateWindow]::SetWindowPos($window, [IntPtr]::Zero,
        $bounds.X, $bounds.Y, $bounds.Width, $bounds.Height, 0x0044)) {
        throw 'Impossible de deplacer Chrome sur l ecran 2.'
    }
    Write-Host 'Chrome ouvert en plein ecran sur DISPLAY2.'
} catch {
    Write-Error $_
    exit 1
}
