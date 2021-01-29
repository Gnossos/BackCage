# WARNING: THIS SOFTWARE IS STILL UNDER DEVELOPMENT; USE AT YOUR OWN RISK #
<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Gnossos/BackCage">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">BackCage</h3>

  <p align="center">
    Local backup and restore iocages and jails on FreeBSD, FreeNAS, and TrueNAS systems
    <br />
    <a href="https://github.com/Gnossos/BackCage"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Gnossos/BackCage">View Demo</a>
    ·
    <a href="https://github.com/Gnossos/BackCage/issues">Report Bug</a>
    ·
    <a href="https://github.com/Gnossos/BackCage/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)

This project is a BASH shell script for creating and restoring local backups of iocage jails on FreeBSD, FreeNAS, and TrueNAS systems.


### Built With

* [Rosettacode: Read a configuration file](http://www.rosettacode.org/wiki/Read_a_configuration_file#UNIX_Shell)
* [Othneil Drew: Best-README-Template](https://github.com/othneildrew/Best-README-Template)
* [NasKar2: Freenas-Backup-Jails](https://github.com/NasKar2/freenas-backup-jails)
* [Raze42: FreeNAS: Backup Jails Automatically Using IOCAGE Import and Export](https://digimoot.wordpress.com/2020/01/11/freenas-backup-jails-automatically-using-iocage-import-and-export/)



<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

Make sure you have the Bourne Again Shell (BASH) installed on your system.

### Installation

1. Download the zip fileS:
   ```NEED TO SHOW HOW
   ```
2. Unzip it
3. Edit the configuration file (cageback_rc.sh) as instructed
4. Install the directory in the appropriate place on your FreeBSD/FreeNAS/TrueNAS system
   


<!-- USAGE EXAMPLES -->
## Usage

backcage.sh [options] [explicit\_cage_names...]

### Options
All options have defaults, so no option _must_ be specified.
>{-B or -b} Backup (default) -- cage(s) will be backed up
>
>-R or -r Restore -- cage(s) will be restored
>
>-C [configuration file path] or -c [configuration file path]; default is "backcage.cfg" in the same folder as backcage.sh. This option requires the path to the configuration file as its argument. See Configuration, below.
>
>-M or -m Menu -- use a menu of available cage(s) to select candidate(s) for backup or restoration.[\^1]
[\^1]:Currently only one cage at a time can be selected from a menu. A future modification might allow the user to select multiple cages from a menu.
>
>-S or -s Secure -- Implements an extra level of security by prohibiting evaluation of configuration statements. This option also has several disadvantages. See the Configuration section below.

### Actions
Backup and restore are two mutually exclusive _actions_. During a single invocation **BackCage** can either backup or restore, but not both. 

### Modes
Backcage operates in one of three modes, depending on the explicit cage names given in the argument list. The modes are: 

<dl>
<dt>Implicit</dt>
<dd>No arguments (explicit names) are given in the argument list. If backup is in effect, all available cages will be backed up. If restore is in effect, the latest backed up iocage jails available will be restored.</dd>
<dt>Explicit</dt>
<dd>One or more arguments (explicit names) are in the argument list. Only these cage(s) will be backed up or restored. If more than one backup exists for an individual cage, the latest will be use unless **Select** is in effect.</dd>
<dt>Menu</dt>
<dd>The list of explicit cage names is treated as a _selection list_ from which a cage may be chosen for backup or restoration. If no explicit cage names are specified, then all cages available will be used to populate the selection list.
</dl>

### Configuration
BackCage has built-in configuration variables with default values, which may be overridden by values in a configuration file. By default this file is named "backcage.cfg," and if it does not exist the built-in values are used instead. An alternative configuration file name can be specified using the -C option.
 

#### Configuration File Format
BackCage uses [Rosetta Code's configuration file format](http://rosettacode.org/wiki/Read_a_configuration_file). Blank lines are ignored, as are lines beginning with a hash (#) or semicolon (;), either of which is usually used for comments.

Other lines consist of the configuration variable name, followed by its assigned value. The name is case insensitive and separated from its value by  either a blank or equals sign. The values are case sensitive, and a single option name may be assigned multiple values separated by commas. Other whitespace is ignored. The configuration format does not allow for values containing commas, but other values with embedded blanks and special characters do not require enclosing quotation marks because the entire value is assigned to the option.

#### Security Considerations
Configuration file processing has been modified to allow "cascading" values. A value assigned to a configuration variable may be used in the values of subsequent configuration variables simply by using the earlier option's name enclosed in curly brackets ("{" and "}") and preceeded by a dollar sign ("$") (see the examples). [NasKar2](https://github.com/NasKar2/freenas-backup-jails) uses this approach for configuraion options, and it has some important advantages:

* It requires less typing
* It is less error prone because earlier values are automatically produced exactly in subsequent assignments
* It allows easier modification because changing an earlier value automatically results in appropriate changes to subsequent values.    

Its main disadvantage is it is less secure. [NasKar2](https://github.com/NasKar2/freenas-backup-jails) includes configuration statements in the backup/restore script itself, so the user has to be able to edit the script. Since the script itself may be executed with root or other high security status, this can be a security risk. Moving configuration statements to a separate file conforms to good programming practices, such as ["encapsulating what changes"](https://dzone.com/articles/10-coding-principles-every-programmer-should-learn). But even then if configuration assignments are executable shell commands read and executed by a shell "source" command, as is commonly done, executable statements in the configuration file can compromise security. Deliberately parsing a configuration file, as Rosetta Code and BackCage do, avoids this threat (but may not eliminate it entirely) because the configuration statements themselves need not be executable (which is why separating option names from values with a space is preferable to using an equals sign), and the parsing can check for a legal, secure format.

Nonetheless, the "cascading" values feature, in which the name of an option assigned a value early in the configuration file can be used to insert the earlier value in subsequent value assignment statements, is implemented here by using the shell script "eval" command, which executes the assigned value as shell statement. While I believe the security risk is less than most alternatives, it is still greater than not evaluating the option value at all.

Therefore, BackCage has a "Secure" option (-S or -s) that turns off such evaluation. If set, then the configuration file must "manually expand" all values to their final values by explicitly typing them in the settings. Note that this option disables the cascading timestamp in the configuration file and instead the BackCage code inserts it in the value from the manually expanded configuration file; this makes file-naming more secure but a bit less flexible than the cascading version.

If the "Secure" option is not used, all configuration assignment statements will be individually evaluated. 

#### Configuration Variables
The configuration variables identify locations in the file system where iocages, jails, and backup-related files reside. The following table describes the variables and their default values.

| Variable       | Description                                                                                  | Default Cascading Values               |
|---------------|-----------------------------------------------------------------------------------------------|--------------------------------|
| POOL_DIR       | Path to the ZFS pool that contains the jails                                                 | /mnt/v1                        |
| LOGS_DIR       | Path to the directory where BackCage stores log files                                        | ${POOL_DIR}/backups/jails/logs |
| LOG_FN         | Name used for individual log files                                                           | JAIL.LOG                       |
| JAILS_DIR      | Path to the directory where jails reside                                                     | ${POOL_DIR}/iocage/jails       |
| JAILS_IMAGES   | Path to the directory where jail images are stored                                           | ${POOL_DIR}/iocage/images      |
| BACKUPS_DIR    | Path to where backup jails are stored                                                        | ${POOL_DIR}/backups/Jails      |
| STAMP          | Template, including a time stamp, for the name assigned to the individual backup directory   | "IOCAGE_"$(date +'%F%H%M')     |    | BACKUP_FN      | Absolute path to the backed up file                                                          | ${BACKUP_LOC}/${FINAL}         |                                
| FULL_LOG_FN    | Absolute path to the backup file                                                             | ${BACKUP_DIR}/${FILE_NAME}     |
| MAX_BACKUPS    | Maximum number of backups to be kept. (When set to 0, all backups are kept.)                 | 2                              |


### Usage examples

* Backup all existing jails:
* 
        backcage.sh
    
  - This also works: ```backcage.sh -b```
  - So does this: ```backcage.sh -B```
        
* Backup two specific cages:

        backcage.sh foo bar
     
* Select cage to backup from a list:

        backcage.sh -M foo bar bas
        
* Restore from the latest backups of all cages for which backups exist:

        backcage.sh -r
        
* Restore one or more specific cages:

        backcage.sh -r foo bar
        
* Select which cage to restore from a menu of all backed up cages:

        backcage.sh -rm
        
* Select which cage to restore from a menu of explicitly named cages:

        backcage.sh -R -M foo bar bas

        
        







<!-- ROADMAP -->
## Roadmap

 [ ] Add Help command to display usage
 [ ] Allow selection of multiple cages


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Your Name - [@I don't use Twitter](https://twitter.com/I don't use Twitter) - Need private email alias

Project Link: [https://github.com/Gnossos/BackCage](https://github.com/Gnossos/BackCage)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [NasKar2: Freenas-Backup-Jails](https://github.com/NasKar2/freenas-backup-jails)
* [Raze42: FreeNAS: Backup Jails Automatically Using IOCAGE Import and Export](https://digimoot.wordpress.com/2020/01/11/freenas-backup-jails-automatically-using-iocage-import-and-export/)


<!-- Notes -->
## Notes



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Gnossos/repo.svg?style=for-the-badge
[contributors-url]: https://github.com/Gnossos/repo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Gnossos/repo.svg?style=for-the-badge
[forks-url]: https://github.com/Gnossos/repo/network/members
[stars-shield]: https://img.shields.io/github/stars/Gnossos/repo.svg?style=for-the-badge
[stars-url]: https://github.com/Gnossos/repo/stargazers
[issues-shield]: https://img.shields.io/github/issues/Gnossos/repo.svg?style=for-the-badge
[issues-url]: https://github.com/Gnossos/repo/issues
[license-shield]: https://img.shields.io/github/license/Gnossos/repo.svg?style=for-the-badge
[license-url]: https://github.com/Gnossos/repo/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/Gnossos
