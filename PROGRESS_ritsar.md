# Ritsar yo'li — progress jurnali

Milestone'lardan keyin bitta qator qo'shiladi: done / next / key values.

- baseline: fight.html o'qildi (474 qator, arena jang prototipi). Grip harness (/tmp/fight_test/grip.html) topildi — sword `sdir=-0.68,-0.13,0.72`, shield `rot=[0,0,-0.5π] off=[0.04,0.1,0] len=0.72` vizual jihatdan yaxshi (idle blade pastga, attack blade tepaga). NEXT: gripni fight.html ga ko'chirish + verify.
- M1 GRIP FIX (done): attachProp `dir` param qo'shildi (setFromUnitVectors (0,-1,0)→dir). Sword: RightHand, len=1.5, off=[0,.05,.04], **dir=[-0.68,-0.13,0.72]**. Shield(kitob): LeftForeArm, len=0.72, **rot=[0,0,-π/2]**, off=[0.04,0.1,0]. In-game idle (blade pastga) + attack (blade tepaga) tasdiqlandi. NEXT: path/obstacles + jump/crouch.
