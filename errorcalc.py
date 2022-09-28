from __future__ import division
import sympy
from sympy import *
from sympy import symbols, diff
from sympy import init_printing
print('Error calculations for Equation 4 in https://doi.org/10.5194/egusphere-2022-327.\n')
print('Calculating partial derivatives....\n')

# Example: 
# x, y, z = symbols('x y z', real=True)
# f = 4*x*y + x**3 + z**8*y
# vars = [x, y, z]


# vars = [N, X, h0, P_Delta]
N, X, h0, P_Delta = symbols('N X h0 P_Delta', real=True)
h_Delta = (sqrt(((2*N*sqrt((X/(2*N))**2-h0**2)-P_Delta)**2-X**2)**2-X**2)/(2*N)) - h0
# vars = [x, y, z]

print(latex(h_Delta))

print('\nCalculating partial derivatives....\n______________\n')

vars = [N, X, h0, P_Delta]
for idx, var in enumerate(vars):
	print('Partial derivative of h_Delta with respect to ' + str(var) + ": ")
	foo = diff(h_Delta, var)
	print(foo)
	print('\n')
	print('In LaTeX: \n')
	print('\\begin{equation}')
	print('\\frac{\\partial h_{\\Delta}}{\\partial ' + str(var) + '} =')
	print(latex(simplify(simplify(foo))))
	print('\\end{equation}\n')
	print('________________________\n')


# foo = diff(f, x)
# print(foo)

# init_printing()
# Integral(sqrt(1/x), x)