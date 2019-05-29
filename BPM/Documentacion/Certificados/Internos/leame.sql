
Banco123*

1. Generar Keystore

2. Generar p12
	- openssl pkcs12 -export -out tomcat.pfx -inkey privateKey.key -in certificate.crt
3. Agergar CA 
	- Desbloquear certificado
	- abrir llavero con keyexplore
	- Desbloquear certificado
	- Edit Certificate Chain --> Append Certificate
	- import CA reply --> FRom file 

Falla #1:
2018-05-07 09:09:31,100 DEBUG [http-nio-443-exec-4] Connection released: [id: 0][route: {s}->https://10.160.88.26:443][total kept alive: 0; route allocated: 0 of 100; total allocated: 0 of 100] (org.apache.http.impl.conn.PoolingHttpClientConnectionManager)
2018-05-07 09:09:31,101 ERROR [http-nio-443-exec-4] Unable to sync configuration (com.manentia.ib.client.frontend.utils.Configuration)
com.manentia.ib.client.frontend.exceptions.NazcaAPIConnectorException: javax.net.ssl.SSLHandshakeException: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target

Solucion: --> Agregar Chain a cacerts de java
copiar /usr/java/jdk1.8.0_91/jre/lib/security/pichincharootca.crt
#Pasos
cd /usr/java/jdk1.8.0_91/jre/lib/security/
keytool -importcert -file pichincharootca.crt -keystore cacerts -alias "pichincharootca" -storepass "changeit"

Falla #2:
2018-05-07 12:07:32,525 DEBUG [http-nio-443-exec-24]  issuer principal: CN=PICHINCHA-ROOT-CA, DC=PICHINCHA, DC=LOCAL (org.apache.http.conn.ssl.SSLConnectionSocketFactory)
2018-05-07 12:07:32,525 DEBUG [http-nio-443-exec-24] Certificate for <10.160.88.26> doesn't match common name of the certificate subject: www.bancopichincha.ws (org.apache.http.conn.ssl.DefaultHostnameVerifier)
javax.net.ssl.SSLException: Certificate for <10.160.88.26> doesn't match common name of the certificate subject: www.bancopichincha.ws
        at org.apache.http.conn.ssl.DefaultHostnameVerifier.matchCN(DefaultHostnameVerifier.java:164)


Solucion
copiar /usr/java/jdk1.8.0_91/jre/lib/security/certificate.crt
cd /usr/java/jdk1.8.0_91/jre/lib/security/
keytool -importcert -file certificate.crt -keystore cacerts -alias "www.bancopichincha.ws" -storepass "changeit"
keytool -importcert -file bancopichincha.cer -keystore cacerts -alias "www.bancopichincha.ws" -storepass "changeit"