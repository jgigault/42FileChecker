# 42FileChecker

<img align="right"  src="./assets/42FileChecker_cropped.png" width="45%" />42FileChecker is a tiny bash script developed at 42 school for testing and checking the files according to the rules of the subjects.

The script is designed as a reminder:
* author file terminated by a Line Feed
* count and files name
* code's standard
* required and forbidden functions
* macro definitionsl
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
cd ~/42FileChecker && sh ./42FileChecker.sh
```
You may also want to set an alias to run it from everywhere, even in your project path. Add this line of code at the end of your shell initialization file (e.g.: `~/.zshrc`):
```bash
alias 42FileChecker='sh ~/42FileChecker/42FileChecker.sh'
```

## non-interactive mode

The non-interactive mode enables you to launch a test suite without any prompt.  
You must specify the two options `--project` and `--path`.  
Here is an example of use with the project `libft`:
```bash
sh ~/42FileChecker/42FileChecker.sh --project "libft" --path "/Users/admin/Projects/libft/"
```

## options

#### `--project` + *`$PROJECT`*

Required for non-interactive mode.  
Specify the name of the project you want to test.  
e.g.: `sh ./42FileChecker.sh --project "libft"`.  
Must be one of the following values: `fillit`, `libft`, `libftasm`, `gnl`, `get_next_line`, `ft_ls`, `ft_printf`, `minishell`.

#### `--path` + *`$PATH`*

Required for non-interactive mode.  
This option has no effect when used without the option `--project`.  
Specify the absolute path of directory of your project.  
e.g.: `sh ./42FileChecker.sh --project "libft" --path "/Users/admin/Projects/libft/"`.

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

## update
At launch, 42FileChecker invites you to get the latest version of the sources and dependencies when available. You may just simply accept or skip the message.

## contribute
If you want to fix or to improve the 42FileChecker, follow the guide lines [**Contributing to 42FileChecker**](https://github.com/jgigault/42FileChecker/wiki/Contributing-to-42FileChecker), or if you want your own unit testing framework to be integrated in the 42FileChecker, just let me know at **jgigault@student.42.fr**

## logo credits

Edouard Audeguy  
Illustrateur / Infographiste  
https://edouardaudeguy.wix.com/portfolio

## bash tips and tricks

42FileChecker has an [**online wiki**](https://github.com/jgigault/42FileChecker/wiki) on github that gives you tips and lessons in Bash programming:
* [**What is Bash**](https://github.com/jgigault/42FileChecker/wiki/What-is-Bash)
* [**What is a bash script**](https://github.com/jgigault/42FileChecker/wiki/What-is-a-Bash-script)
* What is 42FileChecker
* [**Contributing to 42FileChecker**](https://github.com/jgigault/42FileChecker/wiki/Contributing-to-42FileChecker)
    - [Tip: Rebasing a Pull Request](https://github.com/jgigault/42FileChecker/wiki/Contributing-to-42FileChecker#tip1)
* [**Bash syntax: Variables**](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Variables)
    - [1. Declaration](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Variables#part1)
    - [2. Substitution](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Variables#part2)
    - [3. Positional and special parameters](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Variables#part3)
* [**Bash syntax: Conditions**](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Conditions)
    - [1. Conditional expressions](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Conditions#part1)
    - [2. If-then-else](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Conditions#part2)
    - [3. Case-in](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Conditions#part3)
* [**Bash syntax: Functions**](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Functions)
    - [1. Syntax of a function](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Functions#part1)
    - [2. Local and global variables](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Functions#part2)
    - [3. Arguments of a function](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Functions#part3)
    - [4. Passing an array as argument](https://github.com/jgigault/42FileChecker/wiki/Bash-syntax:-Functions#part4)
* Bash builtin commands
* [**Bash tools: Awk**](https://github.com/jgigault/42FileChecker/wiki/Bash-tools:-Awk)
    - [1. How to use AWK](https://github.com/jgigault/42FileChecker/wiki/Bash-tools:-Awk#part1)
    - [2. How works AWK](https://github.com/jgigault/42FileChecker/wiki/Bash-tools:-Awk#part2)
    - [3. AWK built-in variables](https://github.com/jgigault/42FileChecker/wiki/Bash-tools:-Awk#part3)
    - [4. Simple AWK examples](https://github.com/jgigault/42FileChecker/wiki/Bash-tools:-Awk#part4)
* Bash tools: Cat
* Bash tools: Grep
* Bash tools: Sed
* Bash sample code: auto-update (git tool)
* [**Bash sample code: Create an interactive menu**](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Create-an-interactive-menu)
    - [Sample code](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Create-an-interactive-menu#code)
    - [Tip: Convert ASCII number into numeric value](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Create-an-interactive-menu#tip1)
    - [Tip: Check if an index is valid](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Create-an-interactive-menu#tip2)
    - [Tip: Evaluate a string as a command line](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Create-an-interactive-menu#tip3)
* [**Bash sample code: Animated spinner with a time out**](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Animated-spinner-with-a-time-out)
    - [Sample code](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Animated-spinner-with-a-time-out#code)
    - [Tip: Arithmetic operation with floating numbers](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Animated-spinner-with-a-time-out#tip1)
    - [Tip: Check if a process ID has terminated](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Animated-spinner-with-a-time-out#tip2)
    - [Tip: Move the first character to the end of a string](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Animated-spinner-with-a-time-out#tip3)
* Bash sample code: static var test
* [**Bash sample code: Check the basic rules of a makefile**](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Check-the-basic-rules-of-a-makefile)
    - [Sample code](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Check-the-basic-rules-of-a-makefile#code)
    - [Tip: Check if a file or a directory exists](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Check-the-basic-rules-of-a-makefile#tip1)
    - [Tip: Read a whole file into a variable](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Check-the-basic-rules-of-a-makefile#tip2)
    - [Tip: Find a string in a file using awk](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Check-the-basic-rules-of-a-makefile#tip3)
    - [Tip: Get inode of a file](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Check-the-basic-rules-of-a-makefile#tip4)
* Bash sample code: forbidden functions test
* Bash sample code: leaks test
* [**Bash sample code: Create a speed test**](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Create-a-speed-test)
    - [Sample code](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Create-a-speed-test#code)
    - [Tip: Redirect outputs of a command line](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Create-a-speed-test#tip1)
    - [Tip: Count the number of lines of a file](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Create-a-speed-test#tip2)
    - [Tip: Execute a command and save the result in a variable](https://github.com/jgigault/42FileChecker/wiki/Bash-sample-code:-Create-a-speed-test#tip3)

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
