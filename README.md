# Build your own computer

We'll build our own computer — that sounds great. But how do we go about this?

I heard that computers are made by assembling billions of transistors. How can we do this?

> What I cannot create, I do not understand
> — Richard Feynman

A few transistors arranged in clever ways gives rise to simple boolean logic gates like — NOT, OR, AND

And these simple logic gates can be arranged together in clever ways to create more advanced logic to ultimately create a machine that can execute instructions — this is our computer.

![Everthing is Design](images/everything_is_design.png "Everything is Design")

## First steps

Assembling logic gates by hand is a cumbersome process, so let's use something called `Verilog` which allows to assemble many logic gates by just writing some code.

Once we have created our designs in Verilog, we can assemble them together and then "simulate" them

> "Simulation" is just a fancy word for saying "I'd like to see how this would behave in real life, but without actually doing it in real life". And then you use some laws of physics and mathematical formulaes to predict how something will behave in real life, without actually doing it in real life.
> 
> For example, when you are in your physics class, and trying to solve a physics problem — you throw a ball up at a certain velocity and you need to calculate when the ball will reach your hand again. Now you could actually take a ball and throw it up with an exact velocity and then use a stopwatch to see how long it takes to reach your hand again. But this is cumbersome, so we apply some laws of physics and mathematical formulaes, and we get the answer just with some calculations on paper

## Verilog

Once we write our designs in Verilog, we need a way to compile them and simulate them. `Icarus verilog`(`iverilog`) is an open-source tool that can do this for us.

### Requirements

You need to have `iverilog`, `make` and `python` installed on your computer to follow along.

# Running this computer

In this repository, the hardware designs are all in the aptly named `hardware` folder. The `RAM`, `ROM`, `ALU`, `CPU`, `Register`, `PC` and `Computer` are all the designs in this folder.

This `Computer` understands only instructions written as 16-bit numbers, but we don't want to write this by hand. We want to write programs for our computer in easy to understand computer code. So we have a tool called `assembler` which converts the program written in symbolic form (which is easy for us) into the binary form (which is easy for the computer to understand).

### To run the assembler

Let's take a program that we wrote in symbolic form and translate it for our computer.

In the `programs` folder, there are a couple of example programs: `add_2.asm` just adds two numbers. Read the program to understand what is going on.

If you want a slightly more complicated program, `add_first_n.asm` adds the first 50 natural numbers, that is 1 + 2 + 3 + ... + 49 + 50

```bash
python software/assembler/main.py -i programs/add_first_n.hack
```

We have written our assembler in python, so we just run the command above. This will automatically translate our `.asm` program into `.bin` program saved in the `programs` folder.

### To boot up the computer

If you remember the olden days of computers, you would initially insert a floppy disk or a cartridge (ROM) and then switch on the computer, and only then the computer would start executing the program that is already stored in the ROM.

The program is booted with the program already stored in the ROM, and the `reset` button acts as the power on button, and it starts executing the program.

There is a `make` command that takes care of this for you, and you can modify the `ROM_FILE` argument to load the ROM with the binary program of your desire.

```bash
make Computer ROM_FILE=programs/add_first_n.bin               
```

You should now see output like:

```bash
--------------------
WARNING: Reached safety limit of 1000 cycles
RAM[0] =  1275
```

And indeed 1 + 2 + 3 + ... + 49 + 50 = 1575.

So our computer works as expected. We can write even more complex programs, and perhaps write even a virtual machine, and compiler to be able to write programs in even higher-level languages.