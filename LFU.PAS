{ Unit per LF }

Unit LFU;

                     Interface

Uses  graph,crt,dos,LFSU;


Type
     Lev=record             { Tip L‰vizje. Mban kordinatat }
            x,y:integer;    {   dhe kush e b‰n l‰vizjen.   }
            lloj:-1..1;
         end;

     Fushe=array[0..9,0..9] of  -1..1 ;

     Nivel=(fillestar,mesatar,me_pervoje);

Var
    Fu:Fushe;
    Levizje:array[1..60] of lev;
    nl,n1,n2:integer;
    SiLuhet:(njeshe,dyshe);
    Nvl:Nivel;
    Snd:boolean;

procedure InitVar;

procedure ShFush(F:Fushe);

procedure ShNrPullave(var n1,n2:integer;ll:integer);
{ Shkruan numrin e pullave p‰r secil‰n pal‰ }

procedure Gati(ll:integer; var x,y,ngjrr:integer);
{ Nxjerr kursorin te ai q‰ ka rradh‰n e l‰vizjes }

procedure Lexo(var L:lev);
{ Lexon l‰vizjen L dhe ‡elsat e tjer‰ t‰ kontrollit }

procedure Fushe_e_re(F1:Fushe; L:lev; var F2:Fushe; ProcVepruese:boolean);
{ Nga fusha F1 merret fusha F2 n‰p‰rmjet l‰vizjes L          }
{ ProcVepruese tregon n‰se procedura b‰n ndryshime n‰ ekran  }

procedure FundLoje(var ch:char);

procedure Mbyllje;

                Implementation



Const
   ngj_kuti1=magenta;         { ngjyra e par‰ e katror‰ve s‰ fush‰s }
   ngj_kuti2=cyan;            {        e dyt‰                       }
   ngj_pull1=red;             {  ngjyra e pull‰s s‰ par‰  }
   ngj_pull2=blue;            {                  s‰ dyt‰  }
   ngj_kursor1=lightred;      {  ngjyra  e par‰ e kursorit  }
   ngj_kursor2=lightblue;     {          e dyt‰             }
   ngj_info=lightgreen;       { ngj. q‰ shkruhen emrat e lojtar‰ve }
   ngj_help=yellow;           { ngj. q‰ shkruhet rreshti i udh‰zimeve }
   B=56;                      { Brinja e nje katrori te fushes }
   R=25;                      { Rrezja e pullave  }

Var
    i,j:integer;
    ch:char;

function Xp(x:integer):integer;
begin
  Xp:=5 + (B div 2) + (x-1)*B ;
end;

function Yp(y:integer):integer;
begin
  Yp:=5 + (B div 2) + (y-1)*B;
end;

procedure Sinjal;
begin
  sound(500);
  Prit(60);
  sound(800);
  Prit(60);
  sound(600);
  Prit(60);
  nosound;
  Prit(120);
end;

procedure Pulla(x,y,ng:integer);
{ Vendos n‰ fush‰ pull‰n me kordinata  X,Y  dhe me ngjyr‰ NG }
begin
  SetColor(ng);
  SetFillStyle(1,ng);
  FillEllipse(Xp(x),Yp(y),R,R);
  if snd then Sinjal;
end;

procedure RR(x,y,ng:integer);
 { Vizaton nj‰ rreth t‰ trash‰ si pun‰ kursori  }
var  r:integer;
begin
  setcolor(ng);
  for r:=18 to 20 do circle(Xp(x),Yp(y),r);
end; { RR }

procedure Ndricim(n,ng:integer);
{ Ndri‡on ekranin n‰ sh‰nj‰ g‰zimi    }
{ P‰rdoret n‰ procedur‰n ShNrPullave  }
var i:integer;
begin
  for i:=1 to n do begin
                    setbkcolor(ng);
                    Prit(36);
                    setbkcolor(black);
                    Prit(12);
                    end;
end;  { Ndri‡im }

procedure ShNrPullave(var n1,n2:integer;ll:integer);
const col=5+8*B+40;
var nr1,nr2:integer;
    nrstr,pulle,pulla:string;
begin
  nr1:=0;  nr2:=0;
  for i:=1 to 8 do
    for j:=1 to 8 do
      if Fu[i,j]=-1 then nr1:=nr1+1
      else
        if Fu[i,j]=1 then nr2:=nr2+1;
  SetTextStyle(SmallFont,Horizdir,7);
  SetColor(black);
  pulle:=Txt[1];  pulle:=' '+pulle;
  pulla:=Txt[2];  pulla:=' '+pulla;
  str(n1,nrstr);
  if n1=1 then nrstr:=nrstr+pulle  else nrstr:=nrstr+pulla;
  OutTextXY(col,40,nrstr);
  SetColor(white);
  str(nr1,nrstr);
  if nr1=1 then nrstr:=nrstr+pulle  else nrstr:=nrstr+pulla;
  OutTextXY(col,40,nrstr);
  SetColor(black);
  str(n2,nrstr);
  if n2=1 then nrstr:=nrstr+pulle  else nrstr:=nrstr+pulla;
  OutTextXY(col,40+4*B,nrstr);
  SetColor(white);
  str(nr2,nrstr);
  if nr2=1 then nrstr:=nrstr+pulle  else nrstr:=nrstr+pulla;
  OutTextXY(col,40+4*B,nrstr);
  if (ll=-1)and(nr1-n1>5) then Ndricim(nr1-n1,ngj_kursor1);
  if (ll=1)and(nr2-n2>5)  then Ndricim(nr2-n2,ngj_kursor2);
  n1:=nr1;  n2:=nr2;
end;   {  ShNrPullave  }

procedure ShEmLojt(ll:integer);
const col=5+8*b+20;
var LojtKuq,LojtBlu:string;
begin
  LojtKuq:=Txt[3];
  LojtBlu:=Txt[4];
  SetTextStyle(TriplexFont,Horizdir,2);
  SetColor(ngj_info);
  OutTextXY(col,10,LojtKuq);
  OutTextXY(col,4*B+10,LojtBlu);
  ShNrPullave(n1,n2,ll);
end;    { ShEmLojt }

procedure Njoftim(str:string);
var x,y:integer;
    Ndihme:string;
begin
  Ndihme:=Txt[5];
  SetTextStyle(SmallFont,Horizdir,6);
  y:=10+8*b;
  if str='Ndihm‰' then begin
                       SetColor(ngj_help);
                       OutTextXY(15,y,Ndihme);
                       end
   else  begin
         SetColor(black);
         OutTextXY(15,y,Ndihme);
         SetColor(white);
         x:=5 + (8*b-TextWidth(str)) div 2 ;
         OutTextXY(x,y,str);
         sound(700);
         Prit(70);
         nosound;
         repeat until keypressed;
         SetColor(black);
         OutTextXY(x,y,str);
         Njoftim('Ndihm‰');
         end;
end;   {  Njoftim  }

procedure ShFush(F:Fushe);
{   Shfaq  fush‰n   }
var  z:boolean;
begin
  z:=snd;
  snd:=false;
  for i:=1 to 8 do
    for j:=1 to 8 do
      begin
        if odd(i+j) then SetFillStyle(1,ngj_kuti1)
                    else SetFillStyle(1,ngj_kuti2);
        bar(5+(i-1)*B, 5+(j-1)*B, 5+i*B, 5+j*B);
        Case F[i,j] of
          -1: Pulla(i,j,ngj_pull1);
           1: Pulla(i,j,ngj_pull2);
        end;  { case }
      end;
  snd:=z;
  Njoftim('Ndihm‰');
  ShEmLojt(1);
end;    { Shfaq fush‰n }

procedure Trego;
{  Tregon gj‰ndjen e ‡astit  }
var fj:string;
begin
 if snd then fj:=Txt[7] else fj:=Txt[8];
 fj:=fj+'; ';
 if SiLuhet=njeshe then fj:=fj+Txt[17]
 else fj:=fj+Txt[16];
 if SiLuhet=njeshe then
    begin
    fj:=fj+'; ';
    if Nvl=fillestar then fj:=fj+Txt[11]
    else if Nvl=mesatar then fj:=fj+Txt[12]
         else fj:=fj+Txt[13];
    end;
 Njoftim(fj);
end;   { Trego }

{------------------------------NDIHME-----------------------------------}

procedure Sh(x,y,ngmj,ngsh:integer; txt:string);
{ P‰rdoret n‰ procedur‰n   Ndihm‰   }
begin
 GotoXY(x,y);
 TextColor(ngsh);
 TextBackground(ngmj);
 Write(txt);
end;

procedure Sqarime;
{  P‰rdoret n‰ procedur‰n   Ndihm‰   }
var i,x,y:integer;
    t:array[1..15]of string;
begin
  TextBackground(black);
  clrscr;
  for i:=1 to 15 do t[i]:=Txt[26+i];

  y:=4;  x:=(80-length(t[1])) div 2 ;
  Sh(x,y,black,white,t[1]);
  for i:=1 to length(t[1])+2 do Sh(x+i-2,5,black,magenta,#223);

  Sh(2,8,black,lightgreen,t[2]);
  Sh(2,9,black,lightgreen,t[3]);
  Sh(2,10,black,lightgreen,t[4]);
  Sh(2,11,black,lightgreen,t[5]);

  Sh(2,13,black,lightgreen,t[6]);
  Sh(2,14,black,lightgreen,t[7]);
  Sh(2,15,black,lightgreen,t[8]);
  Sh(2,16,black,lightgreen,t[9]);
  Sh(2,17,black,lightgreen,t[10]);
  Sh(2,18,black,lightgreen,t[11]);

  Sh(2,20,black,lightgreen,t[12]);
  Sh(2,21,black,lightgreen,t[13]);
  Sh(2,22,black,lightgreen,t[14]);

  x:=(80-length(t[15])) div 2 ;
  Sh(x,24,black,lightblue,t[15]);

  window(1,25,1,25);
  textcolor(black);
  clrscr;
  readln;
  window(1,1,80,25);
  textcolor(7);
  clrscr;
end;    {  Sqarime  }

procedure Zgjedhje; forward;

procedure Nd;
var i:integer;
    t:array[1..13] of string;
    tt:array[1..5] of string;
    x,y:integer;
begin
  for i:=1 to 13 do t[i]:=Txt[13+i];
  t[2]:=t[2]+':';

  TextBackground(black);
  clrscr;
  y:=3; x:=(80 - length(t[1])) div 2;
  Sh(x,y,black,white,t[1]);
  for i:=1 to length(t[1])+2 do Sh(x-2+i,y+1,black,magenta,#223);
  
  x:=2; y:=y+3;
  Sh(2,y,black,lightred,t[2]);
  x:=x+length(t[2])+1;
  if snd then tt[1]:=Txt[7] else tt[1]:=Txt[8];
  if SiLuhet=njeshe then tt[2]:=Txt[17] else tt[2]:=Txt[16];
  if Nvl=fillestar then tt[3]:=Txt[11]
  else if Nvl=mesatar then tt[3]:=Txt[12] else tt[3]:=Txt[13];
  tt[4]:=Txt[0];
  for i:=1 to 4 do begin
                   Sh(x,y,black,lightgreen,tt[i]);
                   x:=x+length(tt[i]);
                   Sh(x,y,black,lightred,'; ');
                   x:=x+2;  
                   end;
  tt[1]:='2'; tt[2]:='1'; tt[3]:='a'; tt[4]:='b'; tt[5]:='c';
  for i:=1 to 5 do begin
                   Sh(3,7+i,black,white,tt[i]);
                   Sh(7,7+i,black,lightred,t[i+2]);
                   end;
  tt[1]:='*'; tt[2]:='-'; tt[3]:='?';
  for i:=1 to 3 do begin
                   Sh(43,7+i,black,white,tt[i]);
                   Sh(47,7+i,black,lightred,t[i+7]);
                   end;
  Sh(6,14,black,white,'S');
  Sh(7,14,black,lightblue,'hqip');
  Sh(15,14,black,white,'E');
  Sh(16,14,black,lightblue,'nglish');
  Sh(26,14,black,white,'D');
  Sh(27,14,black,lightblue,'eutsch');
  Sh(36,14,black,white,'F');
  Sh(37,14,black,lightblue,'ran‡aise');
  Sh(47,14,black,white,'I');
  Sh(48,14,black,lightblue,'taliano');

  x:=(80-length(t[11])) div 2 -5;   y:=16;
  Sh(x,y,black,lightred,t[11]);
  y:=23;
  Sh(5,y,black,white,'ESC');
  Sh(10,y,black,lightred,t[12]);
  Sh(43,y,black,white,'F1');
  Sh(47,y,black,lightred,t[13]);

  TextColor(black);
  window(1,25,1,25);
  clrscr;
  window(1,1,80,25);
end;   {  Nd  }

procedure Ndihme;
begin
  RestoreCrtMode;
  Nd;
  Zgjedhje;
  SetGraphMode(GetGraphMode);
  ShFush(Fu);
end;   {  Ndihm‰  }

procedure Nj(str:string);
var ch:char;
begin
  str:=' '+str+' ';
  Sh((80-length(str)) div 2,25,red,white,str);
  ch:=readkey;
end;  { Njoftim }

procedure Zgjedhje;
var ch:char;
    OK:boolean;
begin
  repeat
    ch:=readkey;
    ch:=upcase(ch);
    case ch of
      '2': SiLuhet:=dyshe;
      '1': SiLuhet:=njeshe;
      'A': Nvl:=fillestar;
      'B': Nvl:=mesatar;
      'C': Nvl:=me_pervoje;
      '*': if snd then snd:=false else snd:=true;
      'S': Gjuhbaze;
      'E': begin
           ViGjuh('English.lng',Ok);
           if not OK then Nj('File ENGLISH.LNG not found');
           end;
      'D': begin
           ViGjuh('Deutsch.lng',Ok);
           if not OK then Nj('File DEUTSCH.LNG not found');
           end;
      'F': begin
           ViGjuh('Fran‡ais.lng',Ok);
           if not OK then Nj('File FRANCAIS.LNG not found');
           end;
      'I': begin
           ViGjuh('Italiano.lng',Ok);
           if not OK then Nj('Skedario ITALIANO.LNG non e trovato');
           end;
      #59: Sqarime;   { F1  }
    end; { case }
    Nd;
  until ch=#27;
  
end;   { Zgjedhje }

{------------------------------NDIHME-----------------------------------}

procedure KtheLev;
{  Kthen prapa 2 l‰vizjet e fundit   }
{  P‰rdoret n‰ procedur‰n Tjet‰rCase }
begin
  if nl<2 then exit;
  for i:=0 to 9 do
    for j:=0 to 9 do  Fu[i,j]:=0;
  Fu[4,4]:=1; Fu[4,5]:=-1; Fu[5,4]:=-1; Fu[5,5]:=1;
  for i:=1 to nl-2 do Fushe_e_re(Fu,Levizje[i],Fu,false);
  for i:=5 downto 1 do begin
                       sound(400*i);
                       Prit(60);
                       nosound;
                       end;
  nosound;
  ShFush(Fu);
  nl:=nl-2;
end;  {  Kthe levizjen prapa  }

procedure Pyetje;
var  ch:char;
     f:text;
begin
  assign(f,'LP.INI');
  {$I-} rewrite(f); {$I+}
  if ioresult=0 then begin
                     writeln(f,Txt[0]);
                     if SiLuhet=dyshe then write(f,'2') else write(f,'1');
                     if Nvl=fillestar then writeln(f,'a')
                     else if Nvl=mesatar then writeln(f,'b')
                     else writeln(f,'c');
                     close(f);
                     end;
  SetTextStyle(TriplexFont,Horizdir,3);
  Dritare(100,150,100+TextWidth(Txt[50])+40,220,white);
  SetColor(black);
  OutTextXY(120,170,Txt[50]);
  ch:=readkey;
  if ch=Txt[6,1] then Mbyllje
  else ShFush(Fu);
end;   {  Pyetje  }

procedure TjeterCase(c:char);
{ P‰rdoret n‰ procedur‰n  LexoCh  }
var ch:char;
    OK:boolean;
begin
  ch:=UpCase(c);
  Case ch of
    #27: Pyetje;   { Tasti ESC }
    #59: Ndihme;    { Tasti F1 }
    '1': begin SiLuhet:=njeshe; Njoftim(Txt[10])  end;
    '2': begin SiLuhet:=dyshe; Njoftim(Txt[9])  end;
    '*': begin
         snd:=not snd;
         if snd=true then Njoftim(Txt[7]) else Njoftim(Txt[8]);
         end;
    '?': Trego;
    'A': begin Nvl:=fillestar; Njoftim(Txt[18]) end;
    'B': begin Nvl:=mesatar; Njoftim(Txt[19])  end;
    'C': begin Nvl:=me_pervoje; Njoftim(Txt[20]) end;
    '-': KtheLev;
    'S': begin
         GjuhBaze;
         ClearDevice;
         ShFush(Fu);
         end;
    'E': begin
         ViGjuh('English.lng',OK);
         ClearDevice;
         ShFush(Fu);
         if not OK then Njoftim('File ENGLISH.LNG not found');
         end;
    'F': begin
         ViGjuh('Francais.lng',OK);
         ClearDevice;
         ShFush(Fu);
         if not OK then Njoftim('File FRANCAIS.LNG not found');
         end;
    'D': begin
         ViGjuh('Deutsch.lng',OK);
         ClearDevice;
         ShFush(Fu);
         if not OK then Njoftim(' File DEUTSCH.LNG not found');
         end;
    'I': begin
         ViGjuh('Italiano.lng',OK);
         ClearDevice;
         ShFush(Fu);
         if not OK then Njoftim('Skedario ITALIANO.LNG non e trovato');
         end;      
    #1 : begin     { CTRL-A }
         Autor;      
         ClearDevice;
         ShFush(Fu);
         end;
  end;  { case }
end;   { TjeterCase }

procedure Pastrim;
{ Fshin karakteret e shtypura para kohe  }
{ dhe shmang zhurmat e panevojshme       }
{ P‰rdoret n‰ procedur‰n   Lexo          }
var i:integer;
begin
  i:=0;
  repeat
    i:=i+1;
    delay(1);
    if keypressed then ch:=readkey;
  until  i=500;
end;   {  Pastrim  }

procedure Gati(ll:integer; var x,y,ngjrr:integer);
{ P‰rdoret n‰ procedur‰n  Lexo     }
begin
  x:=10;
  if ll=-1 then   begin
                  y:=2;
                  ngjrr:=ngj_kursor1;
                  end
      else   begin
             y:=6;
             ngjrr:=ngj_kursor2;
             end;
  RR(x,y,ngjrr);
end;    {  Gati  }

procedure LexCh(var x,y:integer; var ch:char);
{ P‰rdoret n‰ procedur‰n  Lexo   }
begin
  ch:=readkey;
  case ch of
    #72: begin   { Shigjeta lart }
          y:=y-1;
          if y=0 then y:=8;
          if (x>8) and ((y=1)or(y=5)) then begin
                                            y:=y+1;
                                            x:=x-1;
                                           end;
         end;
    #75: begin   { Shigjeta majtas }
          x:=x-1;
          if x=0 then x:=8;
          end;
    #77: begin   { Shigjeta djathtas }
          x:=x+1;
          if (x=9)or(x=12) then x:=1;
         end;
    #80: begin   { Shigjeta posht‰ }
          y:=y+1;
          if (x>8) and (y=5) then begin
                                  y:=y-1;
                                  x:=x-1;
                                  end;
          if y=9 then
              if x>8 then y:=6 else y:=1;
         end;
    else TjeterCase(ch);
  end; {case}
end;   {  LexCh  }

procedure ZhvendosRR(x1,y1,x,y,ngjrr:integer);
{ P‰rdoret n‰ procedur‰n  Lexo  }
var ngj_sfond:integer;
begin
  ngj_sfond:=GetPixel(Xp(x1),Yp(y1));
  RR(x1,y1,ngj_sfond);
  RR(x,y,ngjrr);
end;   { ZhvendosRR }

function Lejohet(x,y:integer):boolean;
var Lj:boolean;
begin
  { Kontrollohet n‰se ‰sht‰ br‰nda fush‰s }
  Lj := (x>=1)and(x<=8)and(y>=1)and(y<=8);
  if Lj then Lj := Fu[x,y]=0;  { Kontrollohet n‰se kutia ‰sht‰ e lir‰ }
  Lejohet:=Lj;
end;  { Lejohet }

procedure Lexo(var L:lev);
var  ch:char;
     x1,y1,ngjrr,ngj_sfond,i:integer;
begin
with L do
  begin
  Pastrim;
  Gati(lloj,x,y,ngjrr);
  repeat
    repeat
      x1:=x;    y1:=y;
      LexCh(x,y,ch);
      ZhvendosRR(x1,y1,x,y,ngjrr);
    until ch=#13;
  if (not Lejohet(x,y))and(Snd) then begin
                                     sound(900);
                                     Prit(30);
                                     sound(500);
                                     Prit(30);
                                     nosound;
                                     end;
  until Lejohet(x,y);
  end; { with }
end;  { Lexo }

procedure Fushe_e_re(F1:Fushe; l:lev; var F2:Fushe; ProcVepruese:boolean);
var dx,dy,ng:integer;

procedure Ndrysho(var F:Fushe; L:lev; dx,dy:integer);
var x,y,ll,x1,y1:integer;
begin
  x:=l.x;  y:=l.y;  ll:=l.lloj;
  x1:=x;  y1:=y;
  x1:=x1+dx;  y1:=y1+dy;
  while F[x1,y1]=(-1)*ll do
               begin
               x1:=x1+dx;
               y1:=y1+dy;
               end;
   if F[x1,y1]=ll then
      while (x<>x1)or(y<>y1) do  begin
                                 x:=x+dx;
                                 y:=y+dy;
                                 F[x,y]:=ll;
                                 if ((x<>x1)or(y<>y1))and(ProcVepruese)
                                                   then Pulla(x,y,ng);
                                 end;
end;   {  Ndrysho  }

procedure LevKursor(x,y:integer);
var x1,y1:integer;
    uNdryshua:boolean;
begin
  for x1:=10 downto 8 do begin
                         RR(x1,2,ng+8);
                         Prit(200);
                         RR(x1,2,GetPixel(Xp(x1),Yp(2)));
                         end;
  x1:=8;  y1:=2;
  while (y1<>y)or(x1<>x) do
             begin
             uNdryshua:=false;
             repeat
               case random(3) of
                 0,1: if x1<>x then begin
                                    x1:=x1-1;
                                    uNdryshua:=true;
                                    end;
                   2: if y1<>y then begin
                                    if y1>y then y1:=1 else y1:=y1+1;
                                    uNdryshua:=true
                                    end;
               end;   { case }
             until uNdryshua;
             RR(x1,y1,ng+8);
             Prit(200);
             RR(x1,y1,GetPixel(Xp(x1),Yp(y1)));
             end;
  RR(x,y,ng+8);
  Prit(400);
end;   { LevKursor }

begin  {  Fushe e re  }
  with L do begin
            if lloj=-1 then ng:=ngj_pull1 else ng:=ngj_pull2;
            if (lloj=-1)and(SiLuhet=njeshe)and(ProcVepruese)
                                                  then LevKursor(x,y);
            F1[x,y]:=lloj;
            if ProcVepruese then  Pulla(x,y,ng);
            end; { with }
  for dx:=-1 to 1 do
   for dy:=-1 to 1 do  Ndrysho(F1,L,dx,dy);
  F2:=F1;
end;  {  Fushe e re  }

procedure FundLoje(var ch:char);
var s1,s2:string;
    i:integer;
    gjeresi:integer;
begin
  ch:=readkey;
  SetTextStyle(TriplexFont,HorizDir,3);
  if n1>n2 then s1:=Txt[42] else s1:=Txt[43];
  s2:=Txt[44];
  if TextWidth(s1)>TextWidth(s2) then gjeresi:=TextWidth(s1)
                                 else gjeresi:=TextWidth(s2);
  Dritare(80,150,80+gjeresi+30,250,white);
  if n1>n2 then begin
                SetBkColor(red);
                SetColor(lightred);
                end
  else  begin
        SetBkColor(blue);
        SetColor(lightblue);
        end;
  OutTextXY(100,170,s1);
  OutTextXY(100,200,s2);
  for i:=1 to 1000 do begin
                      delay(1);
                      if keypressed then ch:=readkey;
                      end;
  ch:=readkey;
end;     {  FundLoje  }

procedure Mbyllje;
var ch:char;
    v,m,d,dj:word;
begin
  getdate(v,m,d,dj);
  if (v >2000)or(d=1)  then  begin
                             Autor;
                             closegraph;
                             setcolor(7);
                             clrscr;
                             end
  else  if random(3)=0 then  begin
                             closegraph;
                             clrscr;
                             writeln;
                             textbackground(black);
                             textcolor(lightgreen);
                             writeln(Txt[45]);
                             textcolor(lightred);
                             writeln(Txt[46]);
                             textcolor(7);
                             writeln;
                             end
  else begin
       CloseGraph;
       textcolor(7);
       clrscr;
       end;
  halt;
end;   { Mbyllje }


procedure Ini;
var f:text;
    rr:string;
    OK:boolean;
begin
  OK:=false;
  assign(f,'LP.INI');
  {$I-} reset(f); {$I+}
  if ioresult=0 then begin
                     readln(f,rr);
                     rr:=rr+'.lng';
                     ViGjuh(rr,OK);
                     readln(f,rr);
                     close(f);
                     if rr[1]='2' then SiLuhet:=dyshe else Siluhet:=njeshe;
                     case rr[2] of
                       'a': Nvl:=fillestar;
                       'c': Nvl:=me_pervoje;
                     else Nvl:=mesatar;
                     end;{ case }
                     end
  else begin
       SiLuhet:=njeshe;
       Nvl:=mesatar;
       end;
  snd:=true;
end;   {  Ini  }

function Egzist(emsk:string):boolean;
var f:file;
begin
  {$I-}
  assign(f,emsk);
  reset(f);
  close(f);
  {$I+}
  Egzist:=(ioresult=0);
end;  { Egzist }

procedure InitVar;
begin
  if not Egzist('ddd.dat') then begin
                                closegraph;
                                writeln('Missing file DDD.DAT');
                                halt(1);
                                end;
  for i:=0 to 9 do
    for j:=0 to 9 do  Fu[i,j]:=0;
  Fu[4,4]:=1; Fu[4,5]:=-1; Fu[5,4]:=-1; Fu[5,5]:=1;
  n1:=2;  n2:=2;
  nl:=0;
  SetBkColor(black);
  ClearDevice;
  ShFush(Fu);
end;    {  InitVar  }

begin
  Ini;
  randomize;
  Hyrje;
end. { unit }