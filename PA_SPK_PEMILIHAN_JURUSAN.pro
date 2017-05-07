DOMAINS
kelompok             = anggota1(nama,nim,kelas);anggota2(nama,nim,kelas);anggota3(nama,nim,kelas)
nama                 = nama(depan,belakang)
depan,belakang,kelas = string
nim                  = integer
daftar_jawaban       = string*
daftar_pertanyaan    = string*

DATABASE
nondeterm pilihan(string)
nondeterm abcd(symbol,symbol)
nondeterm proses(symbol,char)
nondeterm nama_pasien(string)


PREDICATES
nondeterm mulai
nondeterm inisialisasi
nondeterm data_pengamatan
nondeterm jawabanmu(string,symbol)
nondeterm pertanyaan(daftar_pertanyaan,symbol)
nondeterm jawaban(symbol,daftar_jawaban)
nondeterm begin
nondeterm aturan(integer,string)
nondeterm proses_kembali
nondeterm anggota_kelompok(kelompok)
nondeterm detail_kelompok
nondeterm menu(char)
nondeterm subbegin
jurusan


CLAUSES
begin:-
	write("Siapa nama anda\t: "),readln(Pasien),
	assert(nama_pasien(Pasien)),
	subbegin.

subbegin:-
	inisialisasi,
	write("MASUKAN PILIHAN ANDA = "),
	readchar(Pilih),
	write(" ",Pilih,"\n\n"),
	menu(Pilih),
	write("APAKAH ANDA INGIN MENGULANG LAGI (Y/T) ?"),
	readchar(Jawab),
	write(" ",Jawab),nl,
        assert(proses(jawab,Jawab)),nl,
        proses_kembali.
	
menu(Pilih):-
	Pilih = '1',
	jurusan,
	subbegin;
	
	Pilih = '2',
	mulai;
	
	Pilih = '3',
	detail_kelompok,
	subbegin;
	
	Pilih = '4',
	write("ANDA MEMILIH MENGAKHIRI PROGRAM"),nl,
	write("TERIMA KASIH TELAH MENGGUNAKAN APLIKASI SISTEM PENDUKUNG KEPUTUSAN KAMI"),nl,	
	exit;
	
	Pilih<>'1',Pilih<>'2',Pilih<>'3',Pilih<>'4',nl,
	write("Anda salah memasukan pilihan, masukkan angka 1 sampai 4...\n"),
	subbegin.
	
		
proses_kembali:-
	proses(jawab,'Y');
	proses(jawab,'y'),
	retractall(proses(_,_)),
	write("ANDA MEMILIH MENGULANG PROGRAM"),nl,
	subbegin.

proses_kembali:-
	proses(jawab,'T');
	proses(jawab,'t'),
	retractall(proses(_,_)),
	write("ANDA MEMILIH MENGAKHIRI PROGRAM"),nl,
	write("TERIMA KASIH TELAH MENGGUNAKAN APLIKASI SISTEM PENDUKUNG KEPUTUSAN KAMI"),nl,
	exit. 
	
proses_kembali:-
	write("MAAF ANDA SALAH MEMASUKAN INPUTAN, SILAHKAN MASUKAN ULANG DENGAN BENAR. . .\n"),nl,
	write("APAKAH ANDA INGIN MENGULANG LAGI (Y/T) ?"),
	readchar(Jawab),
	assert(proses(jawab,Jawab)),nl,
        proses_kembali.
	
	
	
mulai:-	
	data_pengamatan,%write("kamu"),nl,
	aturan(_,Alasan),
	jawaban(Alasan,[Jawab1|[Jawab2|[Jawab3|[Jawab4|[Jawab5|_]]]]]),
	write(Jawab1),nl,
	write(Jawab2),nl,
	write(Jawab3),nl,
	write(Jawab4),nl,
	write(Jawab5),nl,
	save("Data Pemilihan Jurusan.txt"),
	retractall(abcd(_,_)).
	
mulai:-
	write("MAAF TIDAK DAPAT MEMBANTU DIKARENAKAN ADA JAWABAN YANG TIDAK SESUAI DENGAN PILIHAN YANG DISEDIAKAN"),nl,nl,
	retractall(abcd(_,_)).
                       
inisialisasi:-
	nl,nl,
	write("********************************************************************************"),nl,
 	write("**		SISTEM PENDUKUNG KEPUTUSAN		     **"),nl,
 	write("**	         PEMILIHAN JURUSAN PERGURUAN TINGGI	                     **"),nl,
 	write("********************************************************************************"),nl,
	nama_pasien(Pasien),
	write("[ ! ] Selamat datang ",Pasien),nl,
 	write("                                             [][][][][] MENU [][][][]"),nl,
 	write("1. JURUSAN"),nl,
	write("2. MULAI UJI"),nl,
 	write("3. ANGGOTA"),nl,
 	write("4. KELUAR / BERHENTI"),nl,
 	write("********************************************************************************"),nl.
	
 	
jurusan:-
	write("[!] JURUSAN YANG TERSEDIA"),nl,
 	write("    - BAHASA/SASTRA	"),nl,
 	write("    - IPS		"),nl,
 	write("    - IPA		").

                     
data_pengamatan:-
	pertanyaan([Soal|[A|[B|[C|[Jawaban|_]]]]],Nomor),nl,
	write(Soal),nl,
	write(A),nl,
	write(B),nl,
	write(C),nl,
	write(Jawaban),
	readln(Jawab),nl,
	jawabanmu(Jawab,Nomor).
	
data_pengamatan.
        
% ------------------------------------------------------------------------------------ JAMAK ---------------------------------------------------------------------------------------------
anggota_kelompok(anggota1(nama("Arief","Hidayat"),1515015109,"C 2015")).
anggota_kelompok(anggota2(nama("Hijratul","Aini"),1515015122,"C 2015")).
anggota_kelompok(anggota3(nama("Muhammad","Sarman Noorlah"),151501512,"C 2015")).

detail_kelompok:-anggota_kelompok(anggota1(nama(A1,B1),C1,D1)),
                 anggota_kelompok(anggota2(nama(A2,B2),C2,D2)),
                 anggota_kelompok(anggota3(nama(A3,B3),C3,D3)),
                 write("\n\n Anggota Kelompok : "),
                 write("\n\n NAMA\t: ",A1," ",B1,"\n NIM\t: ",C1,"\n KELAS\t: ",D1),
                 write("\n\n NAMA\t: ",A2," ",B2,"\n NIM\t: ",C2,"\n KELAS\t: ",D2),
                 write("\n\n NAMA\t: ",A3," ",B3,"\n NIM\t: ",C3,"\n KELAS\t: ",D3),nl.

% ------------------------------------------------------------------------------------ LIST ---------------------------------------------------------------------------------------------
pertanyaan(["1. Kalo lagi ke toko buku, kita pasti langsung pergi ke bagian...","\tA .Sastra, nggak ada yang ngalahin tulisannya Pramoedya Ananta Toer.","\tB. Antropologi atau psikologi dasar gitu, suka pengen tau soal kepribadian manusia.","\tC. Science atau hal-hal yang berhubungan sama komputer dan teknologi.","Masukkan Pilihan Anda = "], nomor1).
pertanyaan(["2. Kalo lagi ngumpul bareng, temen kita nganggep kita...","\tA. Paling jago urusan Bahasa Inggris, apa-apa minta diterjemahin.","\tB. Paling pas kalo ngasih saran dan nasehat, selalu ngena ke permasalahan.","\tC. Tukang ngitung-ngitung kalo mau bayar patungan makan.","Masukkan Pilihan Anda = "],nomor2).
pertanyaan(["3. Pekerjaan impian kita 10 tahun mendatang adalah...","\tA. Wartawan di media massa atau jadi penerjemah di kantor PBB New York! Wow!","\tB. Peneliti kehidupan suku-suku pedalaman Kalimantan atau Papua.","\tC. Pake jas putih, bisa di laboratorium lagi neliti zat kimiawi, atau keliling meriksa pasien di RS.","Masukkan Pilihan Anda = "],nomor3).
pertanyaan(["4. Kita seneng banget nonton film kayak...","\tA. Adaptasi novel Shakespare kayak Romeo Juliet yang romantis gitu.","\tB. The Spotlight atau The Danish Girl, yang ngungkap isu-isu sosial di masyarakat.","\tC. Interstellar atau Gravity yang ngulik soal science dan ilmu antariksa.","Masukkan Pilihan Anda = "],nomor4).
pertanyaan(["5. Saat ini ekskul atau klub sekolah yang kita ikutin adalah...","\tA. English Club sama teater.","\tB. Majalah dan blog sekolah.","\tC. Science club dan robotik.","Masukkan Pilihan Anda = "],nomor5).

jawabanmu(Jawab,Nomor):-
	assert(abcd(Nomor,Jawab)),nl.

% ------------------------------------------------------------------------------------ INI RULE ---------------------------------------------------------------------------------------------
aturan(1, bahasa_sastra):-

		%-----------------------------------100% SASTRA---------------------------------------------------------                
                abcd(nomor1,a),
                abcd(nomor2,a),
		abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\n\t   0% cocok mengambil jurusan IPA"),
                write("\n\n\t   0% cocok mengambil jurusan IPS"),
                write("\n\n\t 100% cocok mengambil jurusan SASTRA");
%-----------------------------------80% SASTRA Dengan 20% IPA----------------------------------------                
                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\n\n\t  20% cocok mengambil jurusan IPA"),
                write("\n\n\n\t   0% cocok mengambil jurusan IPS"),
                write("\n\n\n\t  80% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\n\n\t  20% cocok mengambil jurusan IPA"),
                write("\n\n\n\t   0% cocok mengambil jurusan IPS"),
                write("\n\n\n\t  80% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\n\n\t  20% cocok mengambil jurusan IPA"),
                write("\n\n\n\t   0% cocok mengambil jurusan IPS"),
                write("\n\n\n\t  80% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\n\n\t  20% cocok mengambil jurusan IPA"),
                write("\n\n\n\t   0% cocok mengambil jurusan IPS"),
                write("\n\n\n\t  80% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\n\n\t  20% cocok mengambil jurusan IPA"),
                write("\n\n\n\t   0% cocok mengambil jurusan IPS"),
                write("\n\n\n\t  80% cocok mengambil jurusan SASTRA");
%-----------------------------------80% SASTRA Dengan 20% IPS----------------------------------------                
                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");
%-----------------------------------60% SASTRA Dengan 40% IPA----------------------------------------                
                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t  0% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t  0% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t  0% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t  0% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t  0% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t  0% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t  0% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t  0% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t  0% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t  0% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");
%-----------------------------------60% SASTRA Dengan 40% IPS----------------------------------------                
                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 40% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 40% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 40% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 40% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 40% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 40% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 40% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 40% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 40% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 40% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");
%-----------------------------------60% SASTRA Dengan 20% IPA 20% IPS----------------------------------------                
                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 20% cocok mengambil jurusan IPS"),
                write("\n\t 60% cocok mengambil jurusan SASTRA").
                
                
aturan(2, ips):-

%-----------------------------------100% IPS---------------------------------------------------------                
                abcd(nomor1,b),
                abcd(nomor2,b),
		abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\n\t   0% cocok mengambil jurusan IPA"),
                write("\n\n\t 100% cocok mengambil jurusan IPS"),
                write("\n\n\t   0% cocok mengambil jurusan SASTRA");
%-----------------------------------80% IPS Dengan 20% SASTRA----------------------------------------                
                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\n\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\n\n\t 80% cocok mengambil jurusan IPS"),
                write("\n\n\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 80% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 80% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 80% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 80% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");
%-----------------------------------80% IPS Dengan 20% IPA----------------------------------------                
                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 80% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 80% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 80% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 80% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 80% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");
%-----------------------------------60% IPS Dengan 40% SASTRA----------------------------------------                
                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\t  0% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 40% cocok mengambil jurusan SASTRA");
%-----------------------------------60% IPS Dengan 40% IPA----------------------------------------                
                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 40% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t  0% cocok mengambil jurusan SASTRA");
%-----------------------------------60% IPS Dengan 20% SASTRA 20% IPA----------------------------------------                
                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t 20% cocok mengambil jurusan IPA"),
                write("\n\t 60% cocok mengambil jurusan IPS"),
                write("\n\t 20% cocok mengambil jurusan SASTRA").



aturan(3, ipa):-		
%-----------------------------------100% IPA---------------------------------------------------------                
                abcd(nomor1,c),
                abcd(nomor2,c),
		abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\n\t100% cocok mengambil jurusan IPA"),
                write("\n\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\n\t 0% cocok mengambil jurusan SASTRA");
%-----------------------------------80% IPA Dengan 20% SASTRA----------------------------------------                
                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\n\n\t80% cocok mengambil jurusan IPA"),
                write("\n\n\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\n\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t80% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t80% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t80% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t80% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");
%-----------------------------------80% IPA Dengan 20% IPS----------------------------------------                
                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t80% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t80% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t80% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t80% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t80% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");
%-----------------------------------60% IPA Dengan 40% SASTRA----------------------------------------                
                abcd(nomor1,a),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t40% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t 0% cocok mengambil jurusan IPS"),
                write("\n\t40% cocok mengambil jurusan SASTRA");
%-----------------------------------60% IPA Dengan 40% IPS----------------------------------------                
                abcd(nomor1,b),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t40% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t40% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t40% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t40% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t40% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t40% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t40% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t40% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t40% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t40% cocok mengambil jurusan IPS"),
                write("\n\t 0% cocok mengambil jurusan SASTRA");
%-----------------------------------60% IPA Dengan 20% SASTRA 20% IPS----------------------------------------                
                abcd(nomor1,a),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,a),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,b),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,b),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,a),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,b),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,a),
                abcd(nomor4,c),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,b),
                abcd(nomor3,c),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,a),
                abcd(nomor5,c),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,b),
                abcd(nomor4,c),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA");

                abcd(nomor1,c),
                abcd(nomor2,c),
                abcd(nomor3,c),
                abcd(nomor4,b),
                abcd(nomor5,a),
                write("\n\nDari 5 jawaban yg anda pilih hasilnya :"), 
                write("\n\t60% cocok mengambil jurusan IPA"),
                write("\n\t20% cocok mengambil jurusan IPS"),
                write("\n\t20% cocok mengambil jurusan SASTRA").

% ------------------------------------------------------------------------------------ LIST ---------------------------------------------------------------------------------------------
jawaban(bahasa_sastra,["\n\nAlasannya :\n\t-Kita seneng banget sama hal-hal yang berbau linguistik."," \n\t-Buat kita bahasa itu jendela dunia, karena lewat bahasa kita jadi tau culture lain. "," \n\t-Kita cepet banget nyerap dan ngapalin kosa kata bahasa asing yang baru,"," \n\t-dan cenderung jadi andelan temen-temen kalo udah berurusan sama masalah bahasa."," \n\t-Nantinya, karir kita kebuka lebar di bidang media, sastra atau pemerintahan."]).
jawaban(ips,["\n\nAlasannya :\n\t-Kita seneng banget bergaul sama banyak orang nih. "," \n\t-Buat kita interaksi sosial penting banget dalam kehidupan manusia. "," \n\t-Nggak heran kita pengen banget tau kayak apa sih kehidupan suku pedalaman, atau kayak gimana bangsa lain hidup di masa lalu sebelum adanya modernisasi."," \n\t-Kita juga seneng banget ngamatin isu-isu sosial yang lagi marak diomongin di media. "," \n\t-Rasa penasaran kita ini cocok banget nantinya diaplikasiin saat kita bergelut di bidang antropologi atau jadi pengamat sosial."]).
jawaban(ipa,["\n\nAlasannya :\n\t-Otak kita cenderung kerja pake logika banget mikirnya,karena menurut kita nggak ada hal yang nggak bisa diitung pake eksakta."," \n\t-Buat kita, kepastian itu penting, makanya kita seneng sama hal-hal yang bisa diukur. ","\n\t-Nggak heran kita exciting banget sama angka. ","\n\t-Saat yang lain ngerasain itu beban, buat kita ketemu angka dan hitungan itu menyenangkan banget. ","\n\t-Makanya kita cocok banget kalo kerja di bidang kedokteran atau peneliti biologi."]).


	
	
GOAL
begin.