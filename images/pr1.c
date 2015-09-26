/* CMPSC 473, Project 1, starter kit
 *
 * Sample program for a pipe
 *
 * See http://www.cse.psu.edu/~dheller/cmpsc311/Lectures/Interprocess-Communication.html
 * and http://www.cse.psu.edu/~dheller/cmpsc311/Lectures/Files-Directories.html
 * for some more information, examples, and references to the CMPSC 311 textbooks.
 */

//--------------------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// This makes Solaris and Linux happy about waitpid(); it is not required on Mac OS X.
#include <sys/wait.h>

//--------------------------------------------------------------------------------

void err_sys(char *msg);				// print message and quit

// In a pipe, the parent is upstream, and the child is downstream, connected by
//   a pair of open file descriptors.

void parent_actions(int argc, char *argv[], int fd);	// write to fd
void child_actions(int argc, char *argv[], int fd, int fd2);
void child_actions2(int argc, char *argv[], int fd2);	// read from fd
// fd = file descriptor, opened by pipe()
// treat fd as if it had come from open()

#define BUFFER_SIZE 4096

//--------------------------------------------------------------------------------

int main(int argc, char *argv[])
{ 

	printf("Demonstration of pipe() and fork()\n");

	printf(" 1: PID, PPID: %d %d\n", getpid(), getppid());	// make some noise

	int fd[2];			// pipe endpoints
	int fd2[2];     // second pipe
	pid_t child_pid;
	pid_t child_pid2;
	if (pipe(fd) < 0)
	{
		err_sys("pipe error");
	}

	if ((child_pid = fork()) < 0)
	{       err_sys("fork error");
	}
	else if (child_pid > 0)	// this is the parent
	{
		close(fd[0]);				// read from fd[0]
		parent_actions(argc, argv, fd[1]);	// write to fd[1]
		if (waitpid(child_pid, NULL, 0) < 0)	// wait for child
		{ err_sys("waitpid error"); }
	}
	else				// this is the child
	{



		if (pipe(fd2) < 0)
		{
			err_sys("pipe error");
		}

		if ((child_pid2 = fork()) < 0)
		{       err_sys("fork error");
		}
		else if (child_pid2 > 0)	// this is the parent or child1
		{
			close(fd[1]);				// write to fd[1]
			close(fd2[0]);
			child_actions(argc, argv, fd[0],fd2[1]);		// read from fd[0] and write to fd2[1]

			//parent_actions(argc, argv, fd[1]);	// write to fd[1]
			if (waitpid(child_pid2, NULL, 0) < 0)	// wait for child2
			{ err_sys("waitpid error"); }
		}
		else				// this is the child2
		{
			close(fd2[1]);				// write to fd[1]
			child_actions2(argc, argv, fd2[0]);		// read from fd2[0]
		}

	}
	printf(" 2: PID, PPID: %d %d\n", getpid(), getppid());	// make some noise

	return 0;
}

//--------------------------------------------------------------------------------

// print message and quit

void err_sys(char *msg)
{
	printf("error: PID %d, %s\n", getpid(), msg);
	exit(0);
}

//--------------------------------------------------------------------------------

//p1  

void parent_actions(int argc, char *argv[], int fd)
{
	/* If you want to use read() and write(), this works:
	 *
	 * write(fd, "hello world\n", 12);
	 */

	FILE *fp = fdopen(fd, "w");		// use fp as if it had come from fopen()
	if (fp == NULL)
	{ err_sys("fdopen(w) error"); }

	// The following is so we don't need to call fflush(fp) after each fprintf().
	// The default for a pipe-opened stream is full buffering, so we switch to line
	//   buffering.
	// But, we need to be careful not to exceed BUFFER_SIZE characters per output
	//   line, including the newline and null terminator.
	static char buffer[BUFFER_SIZE];	// off the stack, always allocated
	int ret = setvbuf(fp, buffer, _IOLBF, BUFFER_SIZE);	// set fp to line-buffering
	if (ret != 0)
	{ err_sys("setvbuf error (parent)"); }

	FILE *fp2 = fopen(argv[2], "r");
	if (fp2 == NULL)
	{ err_sys("fdopen(r) error"); }

	static char buffer2[BUFFER_SIZE];
	int ret2 = setvbuf(fp2, buffer2, _IOLBF, BUFFER_SIZE);
	if (ret2 != 0)
	{ err_sys("setvbuf error (child)"); }


	char line[BUFFER_SIZE];
	char *p = fgets(line, BUFFER_SIZE, fp2);	// ends with newline and null_char

	if (p == NULL)	// error or end-of-file; for this program, it's an error
	{ err_sys("fgets error"); }
	fprintf(fp, "[printed to pipe by %d] %s\n", getpid(), line);
	while(p!=NULL) {
		p = fgets(line, BUFFER_SIZE, fp2);	// ends with newline and null_char
		fprintf(fp, "[printed to pipe by %d] %s\n", getpid(), line);
	}
	// use text from command line, with default
	// fflush(fp);
}

//--------------------------------------------------------------------------------

// p2 

void child_actions(int argc, char *argv[], int fd, int fd2)
{
	/* If you want to use read() and write(), this works:
	 *
	 * char line[BUFFER_SIZE];
	 *
	 * int n = read(fd, line, BUFFER_SIZE);
	 * write(STDOUT_FILENO, line, n);
	 */

	// see parent_actions() for similar code, with comments
	FILE *fp = fdopen(fd, "r");

	if (fp == NULL)
	{ err_sys("fdopen(r) error"); }

	static char buffer[BUFFER_SIZE];
	int ret = setvbuf(fp, buffer, _IOLBF, BUFFER_SIZE);
	if (ret != 0)
	{ err_sys("setvbuf error (child)"); }

	FILE *fp2 = fdopen(fd2, "w");
	if (fp2 == NULL)
	{ err_sys("fdopen(r) error"); }

	static char buffer2[BUFFER_SIZE];
	int ret2 = setvbuf(fp2, buffer2, _IOLBF, BUFFER_SIZE);
	if (ret2 != 0)
	{ err_sys("setvbuf error (child)"); }

	char line[BUFFER_SIZE];

	char *p = fgets(line, BUFFER_SIZE, fp);	// ends with newline and null_char
	if (p == NULL)	// error or end-of-file; for this program, it's an error
	{ err_sys("fgets error"); }

	fprintf(fp2, "[printed to pipe by %d] %s", getpid(), line);
	// fflush(stdout);

	close(fd);				// read from fd[0]
	close(fd2);
}

//--------------------------------------------------------------------------------



// p3 

void child_actions2(int argc, char *argv[], int fd)
{
	/* If you want to use read() and write(), this works:
	 *
	 * char line[BUFFER_SIZE];
	 *
	 * int n = read(fd, line, BUFFER_SIZE);
	 * write(STDOUT_FILENO, line, n);
	 */

	// see parent_actions() for similar code, with comments
	FILE *fp = fdopen(fd, "r");

	if (fp == NULL)
	{ err_sys("fdopen(r) error"); }

	static char buffer[BUFFER_SIZE];
	int ret = setvbuf(fp, buffer, _IOLBF, BUFFER_SIZE);
	if (ret != 0)
	{ err_sys("setvbuf error (child)"); }

	char line[BUFFER_SIZE];

	char *p = fgets(line, BUFFER_SIZE, fp);	// ends with newline and null_char
	if (p == NULL)	// error or end-of-file; for this program, it's an error
	{ err_sys("fgets error"); }

	fprintf(stdout, "[printed to file  by %d] %s", getpid(), line);
	// fflush(stdout);
	close(fd);
}




















