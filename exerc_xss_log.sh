#!/bin/bash
#primeiro exercicio de shellscript no redscan academy usando referências do slide
#15/04/2025 - nnaco

#definicão do caminho do log
log="/var/log/apache2/access.log"
#cabeçalho da aplicação
echo "TENTATIVAS XSS DETECTADAS"

echo
#procura padroes xss no log e utilizei o while para  processar linha por linha
#buscando padrões XSS (ex: <script|%3cscript")
grep -iE "<script|%3Cscript" "$log" | while read linha; do
        #busca o ip na linha do log (no caso, primeiro campo separado por espaço)       
        ip=$(echo "$linha" | cut -d ' ' -f 1)
        #apresenta o ip encontrado
        echo "IP: $ip"
        #extrai do 7 campo a diante para capturar o protocolo e as linhas a seguir (codigo, url e parametr>
        echo "Requisição: $(echo "$linha" | cut -d ' ' -f 7-)"
        echo
done

echo "------------------------_"

echo -e "\nIPS ENCONTRADOS"
#conta e em seguida lista a qntidade de ocorrencias por ip
#grep buscando os padroes xss, cut extraindo apenas os IPs(primeira coluna), sort ordena os ips
#uniq -c que conta as ocorrencias  unicas
grep -iE "<script|%3Cscript" "$log" | cut -d ' ' -f 1 | sort | uniq -c

echo -e "\nAnálise concluida"

