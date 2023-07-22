
# Debloat Windows 11

Debloat your windows 11 install with ease.
Still work in progress. Some features might be missing.

## Change Executionpolicy

Open PowerShell with elevated permissions.

```powershell
Set-ExecutionPolicy Unrestricted
```

Select `A` for all.

## Clone the repo

```Powershell
git clone https://github.com/kdpuvvadi/debloat-windows11.git

```

## Quick run

```powershell
iwr https://puvvadi.me/debloat11 | iex
```

or

```powershell
iwr https://git.io/debloat11 | iex
```

## Run

- Right click on the debloat.ps1 and select `run with powershell`.
- Accept the UAC prompt.
- click on the features/bloat you would like to remove or add.

## Feedback/Support

If you have any feedback or need help, please open an issue on the repo.

## Acknowledgements

This is based on windows10debloater by Sycnex.

- [Windows10Debloater](https://github.com/Sycnex/Windows10Debloater)

## License

[MIT](https://choosealicense.com/licenses/mit/)
