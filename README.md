# 42FileChecker

<img align="right"  src="http://i.imgur.com/zvqJlnu.png" width="45%" />42FileChecker is a tiny bash script developped at 42 school for testing and checking the files according to the rules of the subjects.

The script is designed as a reminder:
* author file terminated by a Line Feed
* count and names of files
* code's standard
* required and forbidden functions
* macro and static variables declarations
* makefile rules

Basic tests with compilation are also available for get_next_line and ft_printf (beta), whilst complete unit tests are handled by the "moulitest" (https://github.com/yyang42/moulitest) which is automatically installed and updated.

## install & launch
	git clone https://github.com/jgigault/42FileChecker ~/42FileChecker
	cd ~/42FileChecker && sh ./42FileChecker.sh

## supported projects
<table width="100%">
<thead>
<tr>
<td width="30%" height="60px"></td>
<td width="14%" align="center" cellpadding="0">
<strong>libft</strong>
</td>
<td width="14%" align="center" cellpadding="0">
<strong>gnl</strong>
</td>
<td width="14%" align="center" cellpadding="0">
<strong size="5">ft_ls</strong></ins>
</td>
<td width="14%" align="center" cellpadding="0">
<strong>ft_printf</strong>
</td>
<td width="14%" align="center" cellpadding="0">
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
</tr>
<tr>
<td valign="top" height="60px">norminette</td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
</tr>
<tr>
<td valign="top" height="60px">makefile</td>
<td></td>
<td></td>
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
</tr>
<tr>
<td valign="top" height="60px">leaks</td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
</tr>
<tr>
<td valign="top" height="60px">speed test</td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"></td>
</tr>
<tr>
<td valign="top" height="60px">tests with compilation</td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
<td valign="top" align="center"></td>
</tr>
<tr>
<td valign="top" height="60px">moulitest</td>
<td valign="top" align="center"><kbd>Yes</kbd></td>
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
* The script may automatically install and update the latest version of the "moulitest" project: https://github.com/yyang42/moulitest
* The "norminette" program from 42 school is required