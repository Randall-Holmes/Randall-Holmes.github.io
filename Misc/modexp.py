def modexp(b,e,m):


# make table of exponents
    
    table=[]
    while (e>0):
        table=[e]+table
        e=e//2
    table2=[]

# make table of powers
    
    result=1
    while (len(table)>0):
        result = (result*result)%m
        if table[0]%2==1:
            result = (result*b)%m
        table2 = [[table[0],result]]+table2
        table=table[1:]
        print(table2[0])
    return result

def rabinmiller(b,m):

    if m==2: return 'prime'
    if m%2 == 0: return 'composite'

    e=m-1

# make table of exponents
    
    table=[]
    while (e>0):
        table=[e]+table
        e=e//2
    table2=[]

# make table of powers
    
    result=1
    while (len(table)>0):
        result = (result*result)%m
        if table[0]%2==1:
            result = (result*b)%m
        table2 = [[table[0],result]]+table2
        table=table[1:]
        print(table2[0])

# if m fails the Fermat test it is composite

    print('\n')
    print(table2[0])

    if not table2[0][1] == 1:  return 'composite'

#if top exponent is even, strip it off.  If the
# power found is -1, the number might be prime.
    
    while table2[0][0]%2 == 0:
        table2=table2[1:]
        print('\n')
        print(table2[0])
        if table2[0][1]==m-1:  return 'might be prime'

# if the first power found with odd exponent is 1,
# m might be prime.  Otherwise it is composite.

    if not table2[0][1] == 1:  return 'composite'
    return 'might be prime'
    
        
