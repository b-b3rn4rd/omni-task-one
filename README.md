# Test 1
The following project uses two stage build:
* stage one (builder) exports the certificate from `/docker-java-home/lib/security/cacerts` (prev. imported by `ca-certificates-java` tool)
so that it can be added to the `truststore.ts` as the trusted certificate
* stage two copies `truststore.ts` from the builder stage into current `WORKSPACE` and runs `keytool -list...` to confirm that the certificate is available in the resulting image

## Usage
```bash
$ make
IMAGE_TAG=1.0.0 docker-compose down || true
Removing truststore-1.0.0 ... done
Removing network anz-task-one_default
IMAGE_TAG=1.0.0 docker-compose up
Creating network "anz-task-one_default" with the default driver
Creating truststore-1.0.0 ... done
Attaching to truststore-1.0.0
truststore-1.0.0 | Alias name: debian:cacert.pem
truststore-1.0.0 | Creation date: Mar 26, 2019
truststore-1.0.0 | Entry type: trustedCertEntry
truststore-1.0.0 | 
truststore-1.0.0 | Owner: CN=Chambers of Commerce Root, OU=http://www.chambersign.org, O=AC Camerfirma SA CIF A82743287, C=EU
truststore-1.0.0 | Issuer: CN=Chambers of Commerce Root, OU=http://www.chambersign.org, O=AC Camerfirma SA CIF A82743287, C=EU
truststore-1.0.0 | Serial number: 0
truststore-1.0.0 | Valid from: Tue Sep 30 16:13:43 UTC 2003 until: Wed Sep 30 16:13:44 UTC 2037
truststore-1.0.0 | Certificate fingerprints:
truststore-1.0.0 | 	 SHA1: 6E:3A:55:A4:19:0C:19:5C:93:84:3C:C0:DB:72:2E:31:30:61:F0:B1
truststore-1.0.0 | 	 SHA256: 0C:25:8A:12:A5:67:4A:EF:25:F2:8B:A7:DC:FA:EC:EE:A3:48:E5:41:E6:F5:CC:4E:E6:3B:71:B3:61:60:6A:C3
truststore-1.0.0 | Signature algorithm name: SHA1withRSA
truststore-1.0.0 | Subject Public Key Algorithm: 2048-bit RSA key
truststore-1.0.0 | Version: 3
truststore-1.0.0 | 
truststore-1.0.0 | Extensions: 
truststore-1.0.0 | 
truststore-1.0.0 | #1: ObjectId: 2.5.29.19 Criticality=true
truststore-1.0.0 | BasicConstraints:[
truststore-1.0.0 |   CA:true
truststore-1.0.0 |   PathLen:12
truststore-1.0.0 | ]
truststore-1.0.0 | 
truststore-1.0.0 | #2: ObjectId: 2.5.29.31 Criticality=false
truststore-1.0.0 | CRLDistributionPoints [
truststore-1.0.0 |   [DistributionPoint:
truststore-1.0.0 |      [URIName: http://crl.chambersign.org/chambersroot.crl]
truststore-1.0.0 | ]]
truststore-1.0.0 | 
truststore-1.0.0 | #3: ObjectId: 2.5.29.32 Criticality=false
truststore-1.0.0 | CertificatePolicies [
truststore-1.0.0 |   [CertificatePolicyId: [1.3.6.1.4.1.17326.10.3.1]
truststore-1.0.0 | [PolicyQualifierInfo: [
truststore-1.0.0 |   qualifierID: 1.3.6.1.5.5.7.2.1
truststore-1.0.0 |   qualifier: 0000: 16 30 68 74 74 70 3A 2F   2F 63 70 73 2E 63 68 61  .0http://cps.cha
truststore-1.0.0 | 0010: 6D 62 65 72 73 69 67 6E   2E 6F 72 67 2F 63 70 73  mbersign.org/cps
truststore-1.0.0 | 0020: 2F 63 68 61 6D 62 65 72   73 72 6F 6F 74 2E 68 74  /chambersroot.ht
truststore-1.0.0 | 0030: 6D 6C                                              ml
truststore-1.0.0 | 
truststore-1.0.0 | ]]  ]
truststore-1.0.0 | ]
truststore-1.0.0 | 
truststore-1.0.0 | #4: ObjectId: 2.5.29.18 Criticality=false
truststore-1.0.0 | IssuerAlternativeName [
truststore-1.0.0 |   RFC822Name: chambersroot@chambersign.org
truststore-1.0.0 | ]
truststore-1.0.0 | 
truststore-1.0.0 | #5: ObjectId: 2.5.29.15 Criticality=true
truststore-1.0.0 | KeyUsage [
truststore-1.0.0 |   Key_CertSign
truststore-1.0.0 |   Crl_Sign
truststore-1.0.0 | ]
truststore-1.0.0 | 
truststore-1.0.0 | #6: ObjectId: 2.16.840.1.113730.1.1 Criticality=false
truststore-1.0.0 | NetscapeCertType [
truststore-1.0.0 |    SSL CA
truststore-1.0.0 |    S/MIME CA
truststore-1.0.0 |    Object Signing CA]
truststore-1.0.0 | 
truststore-1.0.0 | #7: ObjectId: 2.5.29.17 Criticality=false
truststore-1.0.0 | SubjectAlternativeName [
truststore-1.0.0 |   RFC822Name: chambersroot@chambersign.org
truststore-1.0.0 | ]
truststore-1.0.0 | 
truststore-1.0.0 | #8: ObjectId: 2.5.29.14 Criticality=false
truststore-1.0.0 | SubjectKeyIdentifier [
truststore-1.0.0 | KeyIdentifier [
truststore-1.0.0 | 0000: E3 94 F5 B1 4D E9 DB A1   29 5B 57 8B 4D 76 06 76  ....M...)[W.Mv.v
truststore-1.0.0 | 0010: E1 D1 A2 8A                                        ....
truststore-1.0.0 | ]
truststore-1.0.0 | ]
truststore-1.0.0 | 
truststore-1.0.0 exited with code 0
```