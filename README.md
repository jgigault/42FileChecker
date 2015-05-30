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

     Updated: 2015/05/30 21:59:14 by jgigault         ###   ########.fr         

At launch, an auto-update feature enables you to keep the latest version of 42FileChecker without manually cloning or merging.

## install & launch
	git clone https://github.com/jgigault/42FileChecker ~/42FileChecker
	cd ~/42FileChecker && sh ./42FileChecker.sh

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
<td valign="top" align="center"></td>
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
	--no-update   // Do not check for updates at launch
	--no-color    // Do not display color tags
	--no-timeout  // Disable time-out child process

## dependencies
* [moulitest](https://github.com/yyang42/moulitest): [@yyang42](https://github.com/yyang42) and other contributors: unit tests
* norminette: [@42born2code](https://twitter.com/42born2code): program for code's standard check
