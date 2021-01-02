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
* _Need documentation template_



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
>-S or -s Select -- use a menu of available cage(s) to select candidate(s) for backup or restoration
>
>-C [configuration file path] or -c [configuration file path]; default is "backcage.cfg" in the same folder as backcage.sh.

Backup and restore are two mutually exclusive _actions_. During a single invocation **backcage** can either backup or restore, but not both. The configuration file option requires the path to the configuration file as its argument.

### Modes
Backcage operates in one of three modes, depending on the explicit cage names given in the argument list. The modes are: 	

<dl>
<dt>Implicit</dt>
<dd>No arguments (explicit names) are given in the argument list. If backup is in effect, all available cages will be backed up. If restore is in effect, the latest backed up iocage jails available will be restored.</dd>
<dt>Explicit</dt>
<dd>One or more arguments (explicit names) are in the argument list. Only these cage(s) will be backed up or restored. If more than one backup exists for an individual cage, the latest will be use unless **Select** is in effect.</dd>
<dt>Select</dt>
<dd>The list of explicit cage names is treated as a _selection list_ from which a cage may be chosen for backup or restoration. If no explicit cage names are specified, then all cages available will be used to populate the selection list.
</dl>

### Usage examples

* Backup all existing cages:
* 
        backcage.sh
    
  - This also works: ```backcage.sh -b```
  - So does this: ```backcage.sh -B```
        
* Backup two specific cages:

        backcage.sh foo bar
     
* Select cage to backup from a list:

        backcage.sh -S foo bar bas
        
* Restore from the latest backups of all cages for which backups exist:

        backcage.sh -r
        
* Restore one or more specific cages:

        backcage.sh -R foo bar
        
* Select which cage to restore from a menu of all backed up cages:

        backcage.sh -rs
        
* Select which cage to restore from a menu of explicitly named cages:

        backcage.sh -R -S foo bar bas

        
        







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

* []()
* []()
* []()





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
