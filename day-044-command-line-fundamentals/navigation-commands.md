# Navigation Commands

## `pwd`

Shows the current working directory.

```bash
pwd
```

## `ls`

Lists visible files and directories.

```bash
ls
```

## `ls -l`

Shows a longer listing.

```bash
ls -l
```

## `ls -a`

Includes hidden files.

```bash
ls -a
```

## `cd`

Changes directory.

```bash
cd sample-data
```

## Parent Directory

```bash
cd ..
```

## Home Directory

```bash
cd ~
```

## Multiple Levels

```bash
cd ../..
```

## Absolute Path Navigation

```bash
cd /home/user/project
```

## Create a Practice Directory

```bash
mkdir command-line-practice
```

## Nested Directory Concept

```bash
mkdir -p command-line-practice/data/raw
```

`-p` means create parent directories as needed.

## Create an Empty Practice File

```bash
touch command-line-practice/notes.txt
```

`touch` is a POSIX example. In PowerShell, file creation uses a different command.

## Safe Navigation Exercises

1. Print the current directory.
2. List files.
3. List files in long format.
4. Include hidden files.
5. Enter `sample-data`.
6. Return to the parent directory.
7. Enter `sample-data` using a relative path.
8. Return home conceptually with `cd ~`.
9. Navigate using `../`.
10. Create a practice folder.
11. Create nested practice folders.
12. Create an empty notes file inside the practice folder.

