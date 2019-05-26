Debugging
---------
  * Overall approach

Finding the root cause of a problem is always challenging. Most bugs are 
subtle and hard to find because if they were obvious, you would’ve avoided 
them in the first place. A good strategy helps. Below I outline a four 
step process that I have found useful:
  
 ** Google!
Whenever you see an error message, start by googling it. If you’re lucky, 
you’ll discover that it’s a common error with a known solution. When 
googling, improve your chances of a good match by removing any variable 
names or values that are specific to your problem.

** Make it repeatable
** Figure out where it is
** Fix it and test it

* Locating errors
Once you’ve made the error repeatable, the next step is to figure out 
where it comes from. The most important tool for this part of the process 
is traceback(), which shows you the sequence of calls (also known as the 
                                                       call stack, 
                                                       Section 7.5) that 
lead to the error.

Here’s a simple example: you can see that f() calls g() calls h() calls 
i(), which checks if its argument is numeric:
  
f <- function(a) g(a)
g <- function(b) h(b)
h <- function(c) i(c)
i <- function(d) {
  if (!is.numeric(d)) {
    stop("`d` must be numeric", call. = FALSE)
  }
  d + 10
}

f("a")
  
Error: `d` must be numeric 
You will see 'Show Traceback' and 'Rerun with Debug'

Click on 'Show Traceback'
5. stop("`d` must be numeric", call. = FALSE) 
4. i(c) 
3. h(b) 
2. g(a) 
1. f("a") 

traceback()
# 5: stop("`d` must be numeric", call. = FALSE) at #3
# 4: i(c) at #1
# 3: h(b) at #1
# 2: g(a) at #1
# 1: f("a")

You can using rlang::with_abort() and rlang::last_trace() to see the call 
tree. Here, it makes it much easier to see the source of the problem. 
Look at the last branch of the call tree to see that the error comes from 
j() calling k().

rlang::with_abort(f(j()))
#> Warning: `rlang__backtrace_on_error` is no longer experimental.
#> It has been renamed to `rlang_backtrace_on_error`. Please update your 
#> RProfile.
#> This warning is displayed once per session.
#> Error: Oops!

# 10.stop(cnd) 
# 9. abort(cnd$message %||% "", error = cnd, trace = trace) 
# 8. h(simpleError(msg, call)) 
# 7..handleSimpleError(function (cnd, ..., top = NULL, bottom = NULL) 
# {
#   check_dots_empty(...)
#   if (!missing(cnd) && inherits(cnd, "rlang_error")) { ... 
#     6.i(c) 
#     5.h(b) 
#     4.g(a) 
#     3.f(j()) 
#     2.withCallingHandlers(expr, error = function (cnd, ..., top = NULL, 
#                                                 bottom = NULL) 
#     {
#       check_dots_empty(...) ... 
#     1.rlang::with_abort(f(j())) 
      
rlang::last_trace()
#>     █
#>  1. ├─rlang::with_abort(f(j()))
#>  2. │ └─base::withCallingHandlers(...)
#>  3. ├─global::f(j())
#>  4. │ └─global::g(a)
#>  5. │   └─global::h(b)
#>  6. │     └─global::i(c)
#>  7. └─global::j()
#>  8.   └─global::k()


* Interactive debugger
Sometimes, the precise location of the error is enough to let you track it 
down and fix it. Frequently, however, you need more information, and the 
easiest way to get it is with the interactive debugger which allows you 
to pause execution of a function and interactively explore its state.

If you’re using RStudio, the easiest way to enter the interactive debugger 
is through RStudio’s “Rerun with Debug” tool. This reruns the command that 
created the error, pausing execution where the error occurred. Otherwise, 
you can insert a call to browser() where you want to pause, and re-run the 
function. For example, we could insert a call browser() in g():
  
  g <- function(b) {
    browser()
    h(b)
  }
f(10)
browser() is just a regular function call which means that you can run it 
conditionally by wrapping it in an if statement:
  
  g <- function(b) {
    if (b < 0) {
      browser()
    }
    h(b)
  }
In either case, you’ll end up in an interactive environment inside the 
function where you can run arbitrary R code to explore the current state. 
You’ll know when you’re in the interactive debugger because you get a 
special prompt:
# Browse[1]>

f(-10)

Next, n: executes the next step in the function. If you have a variable named n, 
you’ll need print(n) to display its value.

Step into,  or s: works like next, but if the next step is a function, 
it will step into that function so you can explore it interactively.

Finish,  or f: finishes execution of the current loop or function.

Continue, c: leaves interactive debugging and continues regular execution 
of the function. This is useful if you’ve fixed the bad state and want to 
check that the function proceeds correctly.

Stop, Q: stops debugging, terminates the function, and returns to the 
global workspace. Use this once you’ve figured out where the problem is, 
and you’re ready to fix it and reload the code.

There are two other slightly less useful commands that aren’t available 
in the toolbar:
  
Enter: repeats the previous command. This is too easy to activate 
accidentally, so I turn it off using options(browserNLdisabled = TRUE).

where: prints stack trace of active calls (the interactive equivalent 
                                           of traceback).

* debug()
Another approach is to call a function that inserts the browser() call for you:
  
debug() inserts a browser statement in the first line of the 
specified function. undebug() removes it. Alternatively, you can use 
debugonce() to browse only on the next run.

utils::setBreakpoint() works similarly, but instead of taking a function 
name, it takes a file name and line number and finds the appropriate 
function for you.

dump.frames()
dump.frames() saves a last.dump.rda file in the working directory. Later, an 
interactive session, you can load("last.dump.rda"); debugger() to enter an 
interactive debugger with the same interface as recover(). This lets you 
“cheat”, interactively debugging code that was run non-interactively.

# In batch R process ----
dump_and_quit <- function() {
  # Save debugging info to file last.dump.rda
  dump.frames(to.file = TRUE)
  # Quit R with error status
  q(status = 1)
}
options(error = dump_and_quit)

# In a later interactive session ----
load("last.dump.rda")
debugger()

===============================================================
* Fundamental Principles of Debugging
* Why Use a Debugging Tool?
* Using R Debugging Facilities
* Ensuring Consistency in Debugging Simulation Code
* Syntax and Runtime Errors

