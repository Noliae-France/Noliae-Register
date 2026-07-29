# Noliae Register

Interface Nolc/.nhtml pour `register.noliae.com`. Elle présente l’inscription
et transmet le formulaire à `/v1/user/register` derrière le reverse proxy
NolCore. La page est volontairement `noindex` et ne stocke aucun secret.

Le cookie de session est émis uniquement par NolCore avec `HttpOnly`, `Secure`,
`SameSite=Lax` et `Domain=.noliae.com` en production.
