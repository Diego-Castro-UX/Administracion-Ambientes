
--> Copiar: 
			--> ca-interna.crt
			--> SSL_Portal-Pichincha-BPM-Interno.crt
			--> SSL_Portal-Pichincha-BPM-Interno.key
													--> clave  = um*q:&_eb=Nh=e(2YNHrQ@qZ

crear carpeta y copiar archivos
/home/edizun503/certificadosbpm/

- Validar certificados 

openssl x509 -in SSL_Portal-Pichincha-BPM-Interno.crt -text
openssl x509 -in ca-interna.crt -text
openssl x509 -in SSL_Portal-Pichincha-BPM-Interno.key -text


1- Convertir un certificado en formato PEM y una clave privada a PKCS#12 (.pfx .p12)

openssl pkcs12 -export -out SSL_Portal-Pichincha-BPM-Interno.pfx -inkey SSL_Portal-Pichincha-BPM-Interno.key -in SSL_Portal-Pichincha-BPM-Interno.crt

Enter Export Password: Banco123*



Fallas 1
[root@qanazcaback1 certificadosbpm]# openssl pkcs12 -export -out SSLBPMInterno.p12 -inkey SSLBPMInterno.key -in SSLBPMInterno.crt
unable to load certificates

--> Leer Certificados
openssl x509 -in SSL_Portal-Pichincha-BPM-Interno.crt -text
openssl x509 -in ca-interna.crt -text

--> Resultado
	[root@qanazcaback1 certificadosbpm]# openssl x509 -in SSLBPMInterno.crt -text
	unable to load certificate
	140073744185232:error:0906D06C:PEM routines:PEM_read_bio:no start line:pem_lib.c:707:Expecting: TRUSTED CERTIFICATE

Solución:
Los certificados vienen cifrados

1. Abrir certificado con keystore
2. Extraer certificado
3. Guardar certificado sin cifrar
