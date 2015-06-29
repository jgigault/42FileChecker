# 42FileChecker

<img align="right"  src="http://i.imgur.com/zvqJlnu.png" width="45%" />42FileChecker is a tiny bash script developped at 42 school for testing and checking the files according to the rules of the subjects.

The script is designed as a reminder:
* author file terminated by a Line Feed
* count and names of files
* code's standard
* required and forbidden functions
* macro definitions
* static variables & functions declarations
* makefile rules

Extra tests are also available:
* memory leaks detection
* speed test comparison
* basic unit tests

Complete unit tests are handled by the [moulitest](https://github.com/yyang42/moulitest), a C project developed by [yyang42](https://github.com/yyang42) and other contributors, whose sources are automatically downloaded, configured and updated when you run the script.

At launch, an auto-update feature enables you to keep the latest version of 42FileChecker without manually cloning or merging.

## install & launch
	git clone https://github.com/jgigault/42FileChecker ~/42FileChecker
	cd ~/42FileChecker && sh ./42FileChecker.sh

Note: Do not change access rights or use aliases to prevent from undefined behaviors.

## supported projects

<table width="100%">
<thead>
<tr>
<td width="30%" height="60px"></td>
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
<strong>fdf</strong>
</td>
</tr>
</thead>
<tbody>
<tr>
<td valign="top" height="60px">auteur</td>
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
<td></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
</tr>
<tr>
<td valign="top" height="60px">makefile</td>
<td></td>
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
</tr>
<tr>
<td valign="top" height="60px">extra functions</td>
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
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
</tr>
<tr>
<td valign="top" height="60px">tests with compilation</td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
</tr>
<tr>
<td valign="top" height="60px">moulitest</td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
</tr>
</tbody>
</table>

## options
```
--no-update      // Do not check for updates at launch
--no-color       // Do not display color tags
--no-timeout     // Disable time-out
--no-norminette  // Disable code's standard check
--no-leaks       // Disable memory leaks detection
--no-speedtest   // Disable speed test comparison
--no-moulitest   // Disable moulitest
```
Add your options as arguments before launch:
```bash
sh ./42FileChecker --no-update --no-timeout
```

## manual

42FileChecker has an [online wiki](https://github.com/jgigault/42FileChecker/wiki) on github that gives you tips and lessons in Bash programming:
* [**What is Bash**](https://github.com/jgigault/42FileChecker/wiki/What-is-Bash)
* [**What is a bash script**](https://github.com/jgigault/42FileChecker/wiki/What-is-a-Bash-script)
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
* Bash tools: Grep, Awk, Sed, Cat
* 42FileChecker: auto-update (git tool)
* [**42FileChecker: interactive menu**](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-interactive-menu)
    - [Sample code](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-interactive-menu#code)
    - [Tip: Convert ASCII number into numeric value](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-interactive-menu#tip1)
    - [Tip: Check if an index is valid](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-interactive-menu#tip2)
    - [Tip: Evaluate a string as a command line](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-interactive-menu#tip3)
* [**42FileChecker: animated spinner with a time out**](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-animated-spinner-with-a-time-out)
    - [Sample code](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-animated-spinner-with-a-time-out#code)
    - [Tip: Arithmetic operation with floating numbers](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-animated-spinner-with-a-time-out#tip1)
    - [Tip: Check if a process ID has terminated](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-animated-spinner-with-a-time-out#tip2)
    - [Tip: Move the first character to the end of a string](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-animated-spinner-with-a-time-out#tip3)
* 42FileChecker: static var test
* 42FileChecker: makefile test
* 42FileChecker: forbidden functions test
* 42FileChecker: leaks test
* [**42FileChecker: speed test**](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-speed-test)
    - [Sample code](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-speed-test#code)
    - [Tip: Redirect outputs of a command line](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-speed-test#tip1)
    - [Tip: Count the number of lines of a file](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-speed-test#tip2)
    - [Tip: Execute a command and save the result in a variable](https://github.com/jgigault/42FileChecker/wiki/42FileChecker:-speed-test#tip3)

## dependencies
* [moulitest](https://github.com/yyang42/moulitest): [@yyang42](https://github.com/yyang42) and other contributors: unit tests
* norminette: [@42born2code](https://twitter.com/42born2code): program for code's standard check
