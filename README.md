# ALProgressHUD
AliasLab Progress HUD (Head Up Display)

A simple ProgressHUD.

![ProgressHub sample image](images/progress_sample.jpg)


## Changes:

**2.3**
- Migration to SPM

**2.2**
- LargeIndicator with text underneath it

**2.1**
- `overApp()`
- `layoutSubviews()` only when `isVisible`

**2.0**
- inherits from `ALVisualEffectView`
- VC should call `setNeedsLayout()` to resize the view after a rotaion of the device. If you want to update the layout of your views immediately, call the `layoutIfNeeded()` method.
