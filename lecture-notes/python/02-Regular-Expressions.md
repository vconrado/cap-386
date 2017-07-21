

# Expressões regulares

O Python disponibiliza o módulo **re** para a utilização de expressões regulares.

Fontes: https://docs.python.org/2/library/re.html, http://wiki.portugal-a-programar.pt/dev_geral:python:regex

Verificando se uma string existe em outra:


```python
import re
 
name = 'Edgar Allan Poe'
if re.search('Allan', name):
    print 'Achou'
re.search('Allan', name)
```

    Achou





    <_sre.SRE_Match at 0x7fa21c2b9f38>



Recomenda-se o uso do **compile** quando o padrão for usado várias vezes:


```python
import re

pattern = re.compile(r'Allan')
names = ("Edgar Allan Poe","Edgar Rice Burroughs","Alanis Morissette","Allan Quatermain")

for name in names:
    if re.search(pattern, name):
        print('Achou em {}'.format(name))
        
print type(pattern)
```

    Achou em Edgar Allan Poe
    Achou em Allan Quatermain
    <type '_sre.SRE_Pattern'>


## Caracteres especiais

( ) [ ] ^ \$ .  + ? \{ \} | 

O padrão que for buscando vir re.search() usando **( )** é armazenado no objeto match e pode ser obtido:


```python
pattern = re.compile("(Allan)")
name = 'Edgar Allan Poe'
groups = re.search(pattern, name).groups()
groups
```




    ('Allan',)



Os **[ ]** servem para indicar alternativas. Por exemplo [xyz] procura por **a** ou **b** ou **c**


```python
pattern = re.compile("[xyz]")
if re.search(pattern, 'Edgar Allan Poe'):
    print 'Achou',
else:
    print 'Não achou'
```

    Não achou



```python
pattern = re.compile("[abc]")
if re.search(pattern, 'Edgar Allan Poe'):
    print 'Achou',
else:
    print 'Não achou'
```

    Achou


### Juntando os dois **( )** com **[ ]**


```python
pattern = re.compile("([abc])")
groups = re.search(pattern, 'Edgar Allan Poe').groups()
groups
```




    ('a',)



Desta forma o re.search trás somente o primeiro **a** que encontrar. Para buscar todos, podemos usar o **re.findall()**. 
PS: ele ja retorna os grupos.


```python
pattern = re.compile("([abc])")
re.findall(pattern, 'Edgar Allan Poe')
```




    ['a', 'a']



### Caracteres especiais dentro do **[ ]**


```python
pattern = re.compile("([a-d])")
re.findall(pattern, 'Edgar Allan Poe')
```




    ['d', 'a', 'a']




```python
pattern = re.compile("([^abcd])")
re.findall(pattern, 'Edgar Allan Poe')
```




    ['E', 'g', 'r', ' ', 'A', 'l', 'l', 'n', ' ', 'P', 'o', 'e']



Fora do **[ ]** os caracteres **^**e **$** tem outro significado.
**^** indica o início da string e **\$** indica o final.


```python
pattern = re.compile("^Edgar")
re.search(pattern, 'Edgar Allan Poe')
```




    <_sre.SRE_Match at 0x7fa21c2c1370>




```python
pattern = re.compile("Allan$")
re.search(pattern, 'Edgar Allan Poe')
```

O carácter **.** (ponto) representa qualquer caracter, exceto o \n.


```python
pattern = re.compile(".")
re.findall(pattern, 'Edgar Allan Poe')
```




    ['E', 'd', 'g', 'a', 'r', ' ', 'A', 'l', 'l', 'a', 'n', ' ', 'P', 'o', 'e']



### Procurando caracteres repetidos

Os caracteres para as repetições são **\***, **+**, **?** e **{ }**.

O **\*** representa "procure por 0 ou mais repetições".


```python
pattern = re.compile("Al*an")
re.search(pattern, 'Edgar Allan Poe') # Match
```




    <_sre.SRE_Match at 0x7fa21c2c15e0>




```python
pattern = re.compile("Edi*gar")
re.search(pattern, 'Edgar Allan Poe') # Match
```




    <_sre.SRE_Match at 0x7fa21c2c1510>



O **+** representa "procure por 1 ou mais repetições".


```python
pattern = re.compile("Al+an")
re.search(pattern, 'Edgar Allan Poe') # Match
```




    <_sre.SRE_Match at 0x7fa21c2c1718>




```python
pattern = re.compile("Edi+gar")
re.search(pattern, 'Edgar Allan Poe') # No match
```

O carácter **?** representa "procure por 0 ou 1 repetição".


```python
pattern = re.compile("All?an")
re.search(pattern, 'Edgar Allan Poe') # Match
```




    <_sre.SRE_Match at 0x7fa21c2c1850>




```python
pattern = re.compile("Edi?gar")
re.search(pattern, 'Edgar Allan Poe') # Match
```




    <_sre.SRE_Match at 0x7fa21c2c1920>



### Greedy e non greey match

Imagine que queremos pegar cada palavra de uma frase. Poderíamos procurar pelo padrão **(.*)** (Qualquer coisa seguida por um espaço. Vamos tentar:


```python
pattern = re.compile("(.*) ")
re.findall(pattern, 'Edgar Allan Poe')
```




    ['Edgar Allan']



O problema neste caso é que esse tipo de busca tenta pegar o máximo possível de carácter (greedy). Uma versão não greedy pode ser feita usando o **?**:


```python
pattern = re.compile("(.*?) ")
re.findall(pattern, 'Edgar Allan Poe')
```




    ['Edgar', 'Allan']



Ou seja, se o **?** estiver depois de um **\*** ou um **+**, significa **non-greddy match**, senão significa "procurar o carácter 0 ou 1 vezes".


```python
pattern = re.compile("(.*?|) ")
re.findall(pattern, 'Edgar Allan Poe')
```




    ['Edgar', 'Allan']



O **{}** possuem dois argumentos, o primeiro indica o mínimo e o segundo o máximo de repetições. 

Um ou dois **s**


```python
pattern = re.compile("Moris{1,2}ette")
re.search(pattern, 'Alanis Morissette') # Match
```




    <_sre.SRE_Match at 0x7fa21c2c1780>




```python
re.search(pattern, 'Alanis Morisette') # Match
```




    <_sre.SRE_Match at 0x7fa21c2c1b90>



Dois ou mais **s**


```python
pattern = re.compile("Moris{2,}ette")
re.search(pattern, 'Alanis Morissette') # Match
```




    <_sre.SRE_Match at 0x7fa21c2c1cc8>




```python
re.search(pattern, 'Alanis Morisette') # No match
```


```python
re.search(pattern, 'Alanis Morissssssette') # Match
```




    <_sre.SRE_Match at 0x7fa21c2c1e00>



### O carácter |

O carácter **|** apenas significa OU. Por exemplo, usar "Allan|Alan" significa procurar por "Allan" ou "Alan".


```python
pattern = re.compile("Allan|Alan")
re.search(pattern, 'Edgar Alan Poe') # Match
```




    <_sre.SRE_Match at 0x7fa21c2c1ed0>



### Atalhos para expressões comuns

- **\d** qualquer dígito (=[0-9])
- **\D** qualquer não dígito (=[^0-9])


```python
re.findall("(\d+)","Idade: 10, Peso: 20.3")
```




    ['10', '20', '3']




```python
re.findall("(\D+)","Idade: 10, Peso: 20")
```




    ['Idade: ', ', Peso: ']



- **\s**: qualquer espaço (espaço, tab, new lines, return carriage)


```python
re.findall("(\s)","Idade: 10, Peso: 20")
```




    [' ', ' ', ' ']



- **\w**: qualquer caracter alfanumérico (=[a-zA-Z0-9_])
- **\W**: qualquer caracter não alfanumérico (=[^a-zA-Z0-9_])


```python
re.findall("(\w+)","Idade: 10, Peso: 20")
```




    ['Idade', '10', 'Peso', '20']




```python
re.findall("(\W)","Idade: 10, Peso: 20")
```




    [':', ' ', ',', ' ', ':', ' ']



### search() vs match()


Python oferece duas operações básicas para fazer o casamento com expressões regulares: 
- re.search(): verifica se um padrão casa em qualquer posição da string
- re.match() verifica se o padrão casa no início da string

Fonte: [search() vs match()](https://docs.python.org/2/library/re.html#search-vs-match)


```python
re.match("c", "abcdef")    # No match
```


```python
re.search("c", "abcdef")   # Match
```




    <_sre.SRE_Match at 0x7fa21c2cf1d0>



Este [site](https://regex101.com/) permite testar expressões regulares com visualização.
