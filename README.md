# 42FileChecker

<img align="right"  src="./assets/42FileChecker_cropped.png" width="45%" />42FileChecker is a tiny bash script developed at 42 school for testing and checking the files according to the rules of the subjects.

The script is designed as a reminder:
* author file terminated by a Line Feed
* count and files name
* code's standard
* required and forbidden functions
* macro definitions
* static variables & functions declarations
* makefile rules

Extra tests may also be performed:
* memory leaks detection
* speed test comparison
* Unit Tests

Complete unit tests are handled through external frameworks whose sources are automatically downloaded, configured and updated in background when you run the script:
* [**moulitest**](https://github.com/yyang42/moulitest), developed by [@yyang42](https://github.com/yyang42) and other contributors
* [**libft-unit-test**](https://github.com/alelievr/libft-unit-test), developed by [@alelievr](https://github.com/alelievr)
* [**fillit_checker**](https://github.com/anisg/fillit_checker), developed by [@anisg](https://github.com/anisg)
* [**Maintest**](https://github.com/QuentinPerez/Maintest), developed by [@QuentinPerez](https://github.com/QuentinPerez) and other contributors
* [**42ShellTester**](https://github.com/we-sh/42ShellTester), developed by [@gabkk](https://github.com/gabkk) and [@jgigault](https://github.com/jgigault)

## install & launch
```bash
git clone https://github.com/jgigault/42FileChecker ~/42FileChecker
cd ~/42FileChecker && bash ./42FileChecker.sh
```
You may also want to set an alias to run it from everywhere, even in your project path. Add this line of code at the end of your shell initialization file (e.g.: `~/.zshrc`):
```bash
alias 42FileChecker='bash ~/42FileChecker/42FileChecker.sh'
```
At launch, 42FileChecker invites you to get the latest version of the sources when available. You may just simply accept or skip the message.

## non-interactive mode

The non-interactive mode enables you to launch a test suite without any prompt.  
You must specify the two options `--project` and `--path`.  
Here is an example of use with the project `libft`:
```bash
bash ~/42FileChecker/42FileChecker.sh --project "libft" --path "/Users/admin/Projects/libft/"
```

## options

#### `--project` + *`$PROJECT`*

Required for non-interactive mode.  
Specify the name of the project you want to test.  
e.g.: `bash ./42FileChecker.sh --project "libft"`.  
Must be one of the following values: `fillit`, `libft`, `libftasm`, `gnl`, `get_next_line`, `ft_ls`, `ft_printf`, `minishell`.

#### `--path` + *`$PATH`*

Required for non-interactive mode.  
This option has no effect when used without the option `--project`.  
Specify the absolute path of directory of your project.  
e.g.: `bash ./42FileChecker.sh --project "libft" --path "/Users/admin/Projects/libft/"`.

#### `--no-update`

Do not check for updates at launch.

#### `--no-color`

Do not display color tags.

#### `--no-timeout`

Disable timeout.

##### `--no-disclaimer`, `--no-auteur`, `--no-author`, `--no-norminette`, `--no-leaks`, `--no-speedtest`, `--no-basictests`, `--no-makefile`, `--no-forbidden`, `--no-staticdeclarations`, `--no-libftfilesexists`, `--no-gnlmultiplefd`, `--no-gnlonestatic`, `--no-gnlmacro`, `--no-moulitest`, `--no-libftunittest`, `--no-fillitchecker`, `--no-maintest`, `--no-42shelltester`

Disable a specific test.

## supported projects

<table width="100%">
<thead>
<tr>
<td width="20%" height="60px"></td>
<td width="12%" align="center" cellpadding="0">
<strong>fillit</strong>
</td>
<td width="12%" align="center" cellpadding="0">
<strong>libft</strong>
</td>
<td width="12%" align="center" cellpadding="0">
<strong>libftasm</strong>
</td>
<td width="12%" align="center" cellpadding="0">
<strong>gnl</strong>
</td>
<td width="12%" align="center" cellpadding="0">
<strong size="5">ft_ls</strong></ins>
</td>
<td width="12%" align="center" cellpadding="0">
<strong>ft_printf</strong>
</td>
<td width="12%" align="center" cellpadding="0">
<strong>minishell</strong>
</td>
</tr>
</thead>
<tbody>
<tr>
<td valign="top" height="60px">author file</td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
</tr>
<tr>
<td valign="top" height="60px">norminette</td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
</tr>
<tr>
<td valign="top" height="60px">makefile</td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
</tr>
<tr>
<td valign="top" height="60px">forbidden functions</td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
</tr>
<tr>
<td valign="top" height="60px">extra functions</td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
</tr>
<tr>
<td valign="top" height="60px">leaks</td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
</tr>
<tr>
<td valign="top" height="60px">speed test</td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
</tr>
<tr>
<td valign="top" height="60px">unit tests</td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
</tr>
<tr>
<td valign="top" height="60px">integration tests</td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
</tr>
</tbody>
</table>

## official team and credits

42FileChecker is an open source project distributed under licence [Apache 2.0](https://github.com/jgigault/42FileChecker/blob/master/LICENCE).

Originally developed by Jean Michel Gigault [@jgigault](https://github.com/jgigault), the team also is composed of:
- [@Seluj78](https://github.com/Seluj78)
- [@adibk](https://github.com/adibk)
- [@kalak-io](https://github.com/kalak-io)

## logo credits

Edouard Audeguy  
Illustrateur / Infographiste  
https://edouardaudeguy.wix.com/portfolio

## contribute

If you want to be part of the project, to fix and to improve the 42FileChecker, please follow the guide lines [**Contributing to 42FileChecker**](https://github.com/jgigault/42FileChecker/wiki/Contributing-to-42FileChecker), or if you want your own unit testing framework to be integrated in the 42FileChecker, just let me know at **jgigault@student.42.fr**.

42FileChecker has an [**online wiki**](https://github.com/jgigault/42FileChecker/wiki) that gives you tips and lessons in Bash programming.

# other scripts

<table width="100%">
<tr>
<td align="center">
<a href="https://github.com/jgigault/42FileChecker">
<img align="center" src="./assets/42FileChecker_250x250.png" />
</a>
</td>
<td align="center">
<a href="https://github.com/jgigault/42MapGenerator">
<img align="center" src="https://github.com/jgigault/42MapGenerator/blob/master/assets/42MapGenerator_250x250.png" />
</a>
</td>
<td align="center">
<a href="https://github.com/we-sh/42ShellTester">
<img align="center" src="https://github.com/we-sh/42ShellTester/blob/master/lib/assets/42ShellTester_250x250.png" />
</a>
</td>
</tr>
<tr>
<td align="center">
<strong>
<a href="https://github.com/jgigault/42FileChecker">42FileChecker</a>
</strong>
</td>
<td align="center">
<strong>
<a href="https://github.com/jgigault/42MapGenerator">42MapGenerator</a>
</strong>
</td>
<td align="center">
<strong>
<a href="https://github.com/we-sh/42ShellTester">42ShellTester</a>
</strong>
</td>
</tr>
</table>
