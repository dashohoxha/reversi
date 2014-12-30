{ Unit special p‰r LF }

Unit LFSU;

Interface

Var
    Txt:array[0..50] of string;
    k:real;  { Koficenti q‰ rregullon pritjen. P‰rdoret n‰ PRIT }

procedure GjuhBaze;
procedure ViGjuh(EmSk:string; var OK:boolean);
procedure Hyrje;
procedure Autor;
procedure Dritare(x1,y1,x2,y2,ng:integer);
procedure Prit(t:integer);


Implementation

uses graph,BGIdriv,BGIfont,crt,dos;

var OK:boolean;

procedure Koficent(var k:real);

{ Llogarit koficentin e pritjes sipas shpejt‰sis‰ s‰ kompjuterit }
var
  h1,h2,m1,m2,s,s1,s2,q,q1,q2:word;
begin
  gettime(h1,m1,s1,q1);
  delay(1000);
  gettime(h2,m2,s2,q2);
  if m1=m2 then begin
                s:=s2-s1;
                q:=q2-q1;
                s:=s*100;
                s:=s+q;
                k:=100/s;
                end
  else Koficent(k);
end;   { Koficent }

procedure Prit(t:integer);
{ Z‰v‰nd‰son procedur‰n Delay }
begin
  t:=round(t*k);
  delay(t);
end; { Prit }

procedure GjuhBaze;
begin
Txt[0]:='Shqip';
Txt[1]:='pull‰';
Txt[2]:='pulla';
Txt[3]:='Lojtari i kuq';
Txt[4]:='Lojtari blu';
Txt[5]:='F1 Ndihm‰  L‰viz me shigjeta  ENTER Vendos  ESC Nd‰rpret';
Txt[6]:='pj';
Txt[7]:='Me z‰';
Txt[8]:='Pa z‰';
Txt[9]:='Luhet me dy lojtar‰';
Txt[10]:='Luhet me programin';
Txt[11]:='Nivel fillestar';
Txt[12]:='Nivel mesatar';
Txt[13]:='Nivel me p‰rvoj‰';
Txt[14]:='€el‰sat e kontrollit';
Txt[15]:='Gj‰ndja e ‡astit';
Txt[16]:='Lojtar^Lojtar';
Txt[17]:='Lojtar^Program';
Txt[18]:='Programi luan si fillestar';
Txt[19]:='Programi luan si mesatar';
Txt[20]:='Programi luan si me p‰rvoj‰';
Txt[21]:='V‰/heq z‰rin';
Txt[22]:='Kthen dy l‰vizjet e fundit';
Txt[23]:='Tregon gj‰ndjen e ‡astit';
Txt[24]:='Shtyp ‡el‰sat pik‰risht tani ose gjat‰ loj‰s';
Txt[25]:='Kthehu te fusha';
Txt[26]:='Rregullat e loj‰s';
Txt[27]:='Si luhet Loja me Pulla';
Txt[28]:='  Loja luhet n‰ nj‰ fush‰ me (8x8) katror‰. Nj‰ri lojtar ka pullat ngjyr‰';
Txt[29]:='blu tjetri t‰ kuqet. Si fillim, 4 pulla jan‰ t‰ vendosura  n‰  q‰nd‰r  t‰';
Txt[30]:='fush‰s. Lojtar‰t vendosin pullat me rradh‰ nj‰ri pas tjetrit';
Txt[31]:='';
Txt[32]:='  Kur rrethohen disa pulla t‰ kund‰rshtarit ato kthehen n‰  ngjyr‰n  ton‰';
Txt[33]:='Rrethim do t‰ thot‰ q‰ nj‰ varg pullash t‰ kund‰rshtarit (pa kuti bosh n‰';
Txt[34]:='mes) ndodhen n‰ mes t‰ dy pullave tona, t‰ cilat jan‰ pik‰risht n‰ skajet';
Txt[35]:='e vargut. Por! Kthehen n‰ ngjyr‰n ton‰ vet‰m ato vargje q‰ rrethohen  nga';
Txt[36]:='pulla q‰ sapo vendosim ne, dhe jo ato q‰ gj‰nden vetvetiu t‰ rrethuara.';
Txt[37]:='';
Txt[38]:='  Loja vazhdon derisa t‰ mbushen t‰ gjitha kutit‰ e fush‰s. E fiton loj‰n';
Txt[39]:='ai q‰ ka m‰ shum‰ pulla.';
Txt[40]:='';
Txt[41]:='ENTER kur ta kesh lexuar';
Txt[42]:='Fitore e t‰ kuqit';
Txt[43]:='Fitore e blus‰';
Txt[44]:='Doni t‰ luani prap‰ ? (p/j)';
Txt[45]:='Kopjimi i loj‰s ‰sht‰ i lejuar nga vet‰ autori.';
Txt[46]:='    Shitja e saj ‰sht‰ e ndaluar.';
Txt[47]:='Loja me';
Txt[48]:='N‰ serin‰ e programeve t‰ tipit "gj‰ e zgjuar"';
Txt[49]:='paraqet:';
Txt[50]:='Megjithm‰nt ? (p/j)';
end;

procedure ViGjuh(EmSk:string; var OK:boolean);
var rr:string;
    f:file of string;
    i:integer;
begin
  i:=0;
  OK:=false;
  assign(f,EmSk);
  {$I-} reset(f); {$I+}
  if ioResult=0 then begin
                     while not eof(f) do
                         begin
                         read(f,rr);
                         Txt[i]:=rr;
                         i:=i+1;
                         end;
                     close(f);
                     OK:=true;
                     end
end;   { ViGjuh }

procedure Hyrje;
label fund;
var i:integer;
    ch:char;
    s:string;
    r:real;
procedure Shkr(x,y:integer;str:string;ng1,ng2:integer; m:integer);
var i:integer;
begin
  settextstyle(triplexfont,horizdir,m);
  setcolor(ng1);
  for i:=3 downto 1 do outtextxy(x-i,y-i,str);
  setcolor(ng2);
  outtextxy(x,y,str);
end;   { Shkr }
procedure MeKercim;
var XX,d,X,Y,X0,Y0,VX0,VY0,i,t,a:integer;
    s:string;
function Shtm(str:string):string;
{ Shkronja t‰ m‰dha }
var Sh:string;
    i:integer;
begin
  Sh:='';
  for i:=1 to length(str) do sh:=sh+UpCase(str[i]);
  Shtm:=Sh;
end;  { Shtm }

begin
  s:=Shtm(Txt[2]);
  d:=(200 div length(s)) + 20;
  XX:=d;  Y0:=400;
  a:=2; VX0:=4; VY0:=-40;
  cleardevice;
  for i:=length(s) downto 1 do
              begin
              if keypressed then exit;
              t:=0;
              XX:=XX-d;
              X0:=XX;
              while X0 < -160  do  X0:=X0+160;
              if s[i]<>' ' then
                              repeat
                                if keypressed then exit;
                                if t=40 then begin
                                             X0:=X;
                                             Y0:=Y;
                                             t:=1;
                                             end
                                else t:=t+1;
                                X := X0 + VX0*t;
                                Y := Y0 + VY0*t + (a*t*t) div 2;
                                Shkr(x,y,s[i],red,lightred,7);
                                Prit(70);
                                Shkr(x,y,s[i],black,black,7);
                              until X > XX+460;
              Shkr(x,y,s[i],red,lightred,7);
  end;  { for }
end;   { Me Kercim }
procedure MeZmadhim;
var s:string;
    x,y,i:integer;
begin
  s:=Txt[47];
  x:=10;  y:=10;
  for i:=1 to 7 do begin
                   Shkr(x+10*i,y+10*i,s,blue,lightblue,i);
                   Prit(25);
                   if keypressed then exit;
                   Shkr(x+10*i,y+10*i,s,black,black,i);
                   end;
  Shkr(x+10*i,y+10*i,s,blue,lightblue,7);
end;  { Me Zmadhim }

begin    { Hyrje }
  ClearDevice;
  r:=random(4);
  if r=1 then S:='AlbaSoft'
  else if r=2 then S:='albasoft'
  else S:='ALBASOFT';
  for i:=1 to length(S) do begin
                           if keypressed then goto fund;
                           Shkr(50+50*i,104,S[i],red,lightred,7);
                           Prit(250);
                           end;
  if keypressed then goto fund;
  Prit(300);
  setcolor(green);
  settextstyle(triplexfont,horizdir,2);
  outtextxy((GetMaxX-TextWidth(Txt[48])) div 2 ,220,Txt[48]);
  if keypressed then goto fund;
  Prit(300);
  SetTextStyle(TriplexFont,HorizDir,7);
  Shkr((GetMaxX-TextWidth(Txt[49])) div 2 ,300,Txt[49],darkgray,black,7);
  for i:=1 to 200 do begin
                      Prit(10);
                      if keypressed then goto fund;
                      end;
  MeKercim;
  if keypressed then goto fund;
  MeZmadhim;
  if keypressed then goto fund;
  Prit(1200);
  fund:
end;    {  Hyrje  }

procedure dritare(x1,y1,x2,y2,ng:integer);
var i:integer;
begin
  setcolor(ng);
  for i:=0 to (x2-x1) do line(x1+i,y1,x1+i,y2);
end;   { Dritare }

procedure Autor;
const ngd=lightblue;               {  Ngjyra e dritares  }
      ng1=green;              {  Ngjyra e pasme e textit  }
      ng2=yellow;         {  Ngjyra e siperme e shkronjave }
      emsk='ddd.dat';   {  Emri i skedarit ku ruhen t‰ dh‰nat  }
type Pike=record
             x,y:integer;
             ng:1..7;
          end;
var  ch:char;
     P:Pike;

procedure Shkr(x,y:integer; txt:string);
var i:integer;
begin
  settextstyle(triplexfont,horizdir,7);
  setcolor(ng1);
  for i:=3 downto 1 do outtextxy(x-i,y-i,txt);
  setcolor(ng2);
  outtextxy(x,y,txt);
end;   { Shkr }

procedure Nxir;
var i,l,k:integer;
    f:file of Pike;
begin
  assign(f,emsk);
  reset(f);
  k:=filesize(f);
  l:=0;
  repeat
    i:=random(k);
    seek(f,i);
    read(f,P);
    if getpixel(P.x,P.y)=P.ng
         then repeat
               if i<k-1 then i:=i+1;
               seek(f,i);
               read(f,P);
              until (getpixel(P.x,P.y)<>P.ng)or(i>=k-2);
    PutPixel(P.x,P.y,P.ng);
    l:=l+1;
  until l>=k-2000;
  Shkr(172,104,'Dashamir');
  Shkr(220,180,'Hoxha');
end;   { Nxir }

begin  { Autor }
  ClearDevice;
  Dritare(150,100,488,270,ngd);
  Nxir;
  repeat until keypressed; ch:=readkey;
end;   { Autor }


procedure InitGraphAndBgi;
var
  GraphDriver, GraphMode, Error : integer;
procedure Abort(Msg : string);
begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;
begin
  { Register all the drivers }
  if RegisterBGIdriver(@CGADriverProc) < 0 then
    Abort('CGA');
  if RegisterBGIdriver(@EGAVGADriverProc) < 0 then
    Abort('EGA/VGA');
  if RegisterBGIdriver(@HercDriverProc) < 0 then
    Abort('Herc');
  if RegisterBGIdriver(@ATTDriverProc) < 0 then
    Abort('AT&T');
  if RegisterBGIdriver(@PC3270DriverProc) < 0 then
    Abort('PC 3270');

  { Register all the fonts }
{  if RegisterBGIfont(@GothicFontProc) < 0 then
    Abort('Gothic');
  if RegisterBGIfont(@SansSerifFontProc) < 0 then
    Abort('SansSerif');                            }
  if RegisterBGIfont(@SmallFontProc) < 0 then
    Abort('Small');
  if RegisterBGIfont(@TriplexFontProc) < 0 then
    Abort('Triplex');

  GraphDriver := Detect;                  { autodetect the hardware }
  InitGraph(GraphDriver, GraphMode, '');  { activate graphics }
  if GraphResult <> grOk then             { any errors? }
  begin
    Writeln('Graphics init error: ', GraphErrorMsg(GraphDriver));
    Halt(1);
  end;
end;   { InitGraphAndBgi }

begin
  Koficent(k);
  randomize;
  GjuhBaze;
  InitGraphAndBgi;
end.