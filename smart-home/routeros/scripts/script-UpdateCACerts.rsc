{
  :do {
      /tool fetch url=https://mkcert.org/generate/ check-certificate=yes dst-path=cacert.pem;
      /certificate remove [ find where authority expired ];
      /certificate import file-name=cacert.pem passphrase="";
      /file remove cacert.pem;
      :log info ("CACERT: Updated certificate trust store");
      /tool/e-mail send subject="[RT1-Office-NR2] UpdateCACerts completed succesfully" body="Script UpdateCACerts completed successfully." to=simsrw73@gmail.com;
  } on-error={
      :log error ("CACERT: Failed to update certificate trust store");
      /tool/e-mail send subject="[RT1-Office-NR2] UpdateCACerts FAILED!" body="Script UpdateCACerts did not complete successfully." to=simsrw73@gmail.com;
  };
}