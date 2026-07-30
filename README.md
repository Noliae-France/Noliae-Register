<div align="center">

# Noliae Register

### Création de compte Noliae — Nolc MVC

[![CI](https://github.com/Noliae-France/Noliae-Register/actions/workflows/ci.yml/badge.svg)](https://github.com/Noliae-France/Noliae-Register/actions/workflows/ci.yml)

</div>

Application servie sur **`register.noliae.com`**, construite avec des
contrôleurs Nolc et une vue `.nhtml`. Elle reprend la charte Noliae Pulse et
sert exclusivement l’entrée d’inscription ; aucun secret ni mot de passe n’est
persisté dans ce dépôt ou dans le navigateur.

## Architecture et sécurité

```text
register.noliae.com → reverse proxy → NolCore /v1/user/register → PostgreSQL
```

Le Core hache les mots de passe avec Argon2id, envoie l’éventuel e-mail de
vérification et crée les sessions après connexion. Cette interface est `noindex,nofollow` et
envoie le formulaire uniquement vers le reverse proxy NolCore.

En production, configurez `NOLIAE_COOKIE_DOMAIN=.noliae.com`,
`NOLIAE_COOKIE_SECURE=true` et HTTPS : le cookie `nol_session` reste
`HttpOnly`, `SameSite=Lax`, signé, lié à l’IP et valable 24 h.

Le lien « Se connecter » conserve le même environnement de déploiement :
`register.beta.noliae.com` cible `login.beta.noliae.com` automatiquement.

## Développement

```sh
nolc nhtml views/register.nhtml
nolc check main.nol
docker build -t noliae-register .
```

La CI compile le binaire Nolc, smoke-teste `/api/health` et publie l’image
`ghcr.io/noliae-france/noliae-register:main`.
