# Premade Applicants Filter

Premade Applicants Filter helps you limit the visible applicants of the LFG Premade Groups tool.

### Keywords

**Standard keywords**

| Keyword        | Type    | Description |
|----------------|---------|-------------|
| `level`        | integer | Applicant level |
| `ilvl`         | integer | Maximum item level |
| `myilvl`       | integer | Your own item level (for comparison) |
| `hlvl`         | integer | Honor level |
| `relationship` | string  | Your relationship to the applicant (friend, guild or empty) |
| `friend`       | boolean | If applicant is in your friend list |
| `guild`        | boolean | If applicant is in your guild |
| `tank`         | boolean | If applicant would like to play tank |
| `healer`       | boolean | If applicant would like to play heal |
| `heal`         | boolean | Synonym for `heal` |
| `damage`       | boolean | If applicant would like to play damage dealer |
| `dps`          | boolean | Synonym for `damage` |
| `range`        | boolean | If applicant's class can be a ranged class |
| `melee`        | boolean | If applicant's class can be a melee class |

**Class keywords**

| Keyword        | Type    | Description |
|----------------|---------|-------------|
| `deathknight`  | boolean | If applicant is a deathknight |
| `demonhunter`  | boolean | If applicant is a demonhunter |
| `druid`        | boolean | If applicant is a druid |
| `hunter`       | boolean | If applicant is a hunter |
| `paladin`      | boolean | If applicant is a paladin |
| `priest`       | boolean | If applicant is a priest |
| `mage`         | boolean | If applicant is a mage |
| `monk`         | boolean | If applicant is a monk |
| `rogue`        | boolean | If applicant is a rogue |
| `shaman`       | boolean | If applicant is a shaman |
| `warlock`      | boolean | If applicant is a warlock |
| `warrior`      | boolean | If applicant is a warrior |

**Provided by [Premade Regions](https://github.com/0xbs/premade-regions)**

| Keyword        | Type    | Description |
|----------------|---------|-------------|
| `region`       | string  | Region name of the applicant |
| `oce`          | boolean | If the region of the applicant is Oceanic |
| `usp`          | boolean | If the region of the applicant is US Pacific |
| `usm`          | boolean | If the region of the applicant is US Mountain |
| `usc`          | boolean | If the region of the applicant is US Central |
| `use`          | boolean | If the region of the applicant is US East |
| `mex`          | boolean | If the region of the applicant is Mexico |
| `bzl`          | boolean | If the region of the applicant is Brazil |

**Provided by Raider.IO**

| Keyword             | Type    | Description | Example |
|---------------------|---------|-------------|---------|
| `hasrio`            | boolean | If the group leader has a raider.io profile|`hasrio`|
| `norio`             | boolean | If the the group leader does not have a raider.io profile|`( norio or rio > 500 )`|
| `rio`               | integer | Raider.io ranking of the group leader|`rio > 500`|
| `rioprev`           | integer | Raider.io ranking in previous season|`rioprev > 500`|
| `riomain`           | integer | Raider.io ranking of main character|`riomain > 500`|
| `rioprevmain`       | integer | Raider.io ranking of main character in previous season|`rioprevmain > 500`|
| `riokey5plus`       | integer | Number of dungeons the group leader completed with keystone of level 5 or higher|`riokey5plus >= 5`|
| `riokey10plus`      | integer | Number of dungeons the group leader completed with keystone of level 10 or higher|`riokey10plus >= 5`|
| `riokey15plus`      | integer | Number of dungeons the group leader completed with keystone of level 15 or higher|`riokey15plus >= 5`|
| `riokey20plus`      | integer | Number of dungeons the group leader completed with keystone of level 20 or higher|`riokey20plus >= 5`|
| `riokeymax`         | integer | The maximum keystone level the group leader completed|`riokeymax >= 10`|
| `rionormalprogress` | integer | The number of bosses killed in the current raid on normal difficulty (e.g. 2 means any two bosses killed)|`rionormalprogress > 0`|
| `rioheroicprogress` | integer | The number of bosses killed in the current raid on heroic difficulty (e.g. 2 means any two bosses killed)|`rioheroicprogress > 0`|
| `riomythicprogress` | integer | The number of bosses killed in the current raid on mythic difficulty (e.g. 2 means any two bosses killed)|`riomythicprogress > 0`|
| `riomainprogress`   | integer | The maximum number of bosses killed in the current raid on any difficulty with the main character (i.e. you are looking at a twink)|`riomainprogress > 0`|
| `rionormalkills`    | table   | A table that contains the number of kills for each boss on normal difficulty|`rionormalkills[1] > 0` means first boss killed at least once|
| `rioheroickills`    | table   | A table that contains the number of kills for each boss on heroic difficulty|`rioheroickills[8] > 0` means 8th boss killed at least once|
| `riomythickills`    | table   | A table that contains the number of kills for each boss on mythic difficulty|`riomythickills[3] > 0` means third boss killed at least once|
| `rioraidbosscount`  | integer | Number of bosses in the current raid|`rionormalkills[rioraidbosscount] > 0` means last boss in the raid killed at least once on normal|

### License

The software is provided under the GNU General Public License, Version 3. See the `LICENSE` file for details.
