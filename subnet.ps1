# SameSubnetCalculator.ps1
# Calculator to determine if two IP addresses are on the same subnet.
# Prints out and compares the respective IP network ID's of the 
# two entered IP addressess when supplied with the subnet mask.
# Written by BigTeddy November 09 2011
# Version 1.1

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

function BAndOctets([string[]]$octets1,[string[]] $octets2) {
    $result = @()
    for ($i=0; $i -lt 4; $i++) {
        $result += $octets1[$i] -band $octets2[$i]
        }
    $result
    }

function CompareOctets([string]$octets1,[string]$octets2) {
    if ($octets1 -eq $octets2) {
        "Same subnet"
        }
    else {
        "Different subnets"
        }
    }

function ValidateInput {
    $regex = '\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b'
    ($Addr1TextBox.Text -match $regex) -and  ($Addr2TextBox.Text -match $regex) `
        -and ($SubnetTextBox.Text -match $regex)
    }

function Calculate {
    $addr1 = ($Addr1TextBox.Text) -split '\.'
    $addr2 = ($Addr2TextBox.Text) -split '\.'
    $snetmask = ($SubnetTextBox.Text) -split '\.'
    $Network1Label.Text = (BAndOctets $addr1 $snetmask) -join '.'
    $Network2Label.Text = (BAndOctets $addr2 $snetmask) -join '.'
    $MessageLabel.Text = CompareOctets $Network1Label.Text $Network2Label.Text
    $NworkIDLabel.Text = 'Network ID'
    }

function ClearInput {
    $Network1Label.Text = $Network2Label.Text = $MessageLabel.Text = `
        $Addr1TextBox.Text = $Addr2TextBox.Text = $SubnetTextBox.Text = ''
    $Addr1TextBox.Focus()
    }

# Main script
$sb={
if (ValidateInput) {
    Calculate
    }
else {
    ClearInput
    $MessageLabel.Text = 'Invalid IP address'
    }
}

# Form setup