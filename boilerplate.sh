#!/bin/bash

# Hello, this is a boilerplate script to set a new program in C
# This script counts on a libft directory in the directory above the boilerplate directory

#Create Directories
mkdir new_project;
cd new_project;
mkdir src;
mkdir inc;
# Copy libft
cp -r ../../libft libft

#Create Makefile
touch Makefile;
echo 'NAME 	= hello_world
CC		= cc -Wall -Wextra -Werror -g
SRC		= $(wildcard src/*.c)
OBJ		= $(SRC:.c=.o)
HEADER	= include/data.h libft/include/libft.h
IFLAG	= -I./include
LIBFT	= libft/libft.a
#LINKER = -lreadline -ltermcap

all: $(NAME) $(LIBFT)

$(LIBFT):
	@make -C libft/ all

$(NAME): $(OBJ) $(LIBFT)
	@$(CC) $(OBJ) $(LIBFT) $(IFLAG) -o $(NAME)

%.o: %.c $(HEADER)	
	@$(CC) -c $< -o $@ $(IFLAG)

clean:
	@make -C ./libft clean
	@rm -f src/*.o
	@rm -f *.o

fclean: clean
	@rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re libft hello_world' >> Makefile

#create header file
cd inc
touch data.h
chmod +x data.h
echo '#ifndef PHILO_H
# define PHILO_H

# include "../libft/include/libft.h"
# include <sys/wait.h>
# include <sys/types.h>
# include <sys/stat.h>
# include <unistd.h>
# include <stdlib.h>
# include <stdio.h>
# include <fcntl.h>
# include <termcap.h>
# include <curses.h>
# include <term.h>
# include <string.h>
# include <errno.h>
# include <stdbool.h>
# include <signal.h>
# include <readline/readline.h>
# include <readline/history.h>

typedef struct s_data	t_data;

typedef struct s_data
{
	char *s;
}	t_data;

//main
int		main(int ac, char **av);

//valid
void	validate_args(int ac, char **av);

//init
void	init_data(t_data *t, char **av);

//hello world
void	hello_world(t_data *t);

//free
void free_data(t_data *d);

#endif' > data.h

# Create Source Files

cd ../src
touch main.c validate_args.c init_data.c free_data.c hello_world.c
chmod +x *.c
for file in $(ls); do
	echo '#include "../inc/data.h"' > "$file"
done

# Write Main File
echo '

int	main(int ac, char **av);

int	main(int ac, char **av)
{
	t_data	*t;

	t = malloc(sizeof(t_data));
	if (!t)
		return (EXIT_FAILURE);
	validate_args(ac, av);
	init_data(t, av);
	hello_world(t);
	free_data(t);
	return (EXIT_SUCCESS);
}
' >> main.c

# Validate Args
echo '
void	validate_args(int ac, char **av)
{
	if (ac != 2)
	{
		printf("Usage: <arg1>\n");
		exit(EXIT_FAILURE);
	}
	if (!av[1])
		exit(EXIT_FAILURE);
}' >> validate_args.c

# Initialize Data Structure
echo '
void	init_data(t_data *t, char **av);

void	init_data(t_data *t, char **av)
{
	t->s = av[1];
	if (!t->s)
	{
		free(t);
		exit(EXIT_FAILURE);
	}
}' >> init_data.c

# Hello World
echo '
void	hello_world(t_data *t);

void	hello_world(t_data *t)
{
	printf("Hello, %s\n", t->s);
}' >> hello_world.c

# Free Data

echo '
void	free_data(t_data *t);

void	free_data(t_data *t)
{
	free(t);
}' >> free_data.c
