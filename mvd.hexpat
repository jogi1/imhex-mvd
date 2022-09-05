#pragma endian little

enum MessageType : u8 {
    Bad                = 0,
    Nop                 = 1,
    Disconnect          = 2,
    Updatestat          = 3,  // [byte] [byte]
    NQVersion          = 4,  // [long] server version
    Setview             = 5,  // [short] entity number
    Sound               = 6,  // <see code>
    NQTime             = 7,  // [float] server time
	Print               = 8,  // [byte] id [string] null terminated string
	Stufftext           = 9,  // [string] stuffed into client's console buffer
	Setangle            = 10, // [angle3] set the view angle to this absolute value
	Serverdata          = 11, // [long] protocol ...
	Lightstyle          = 12, // [byte] [string]
	NQUpdatename       = 13, // [byte] [string]
	Updatefrags         = 14, // [byte] [short]
	NQClientdata       = 15, // <shortbits + data>
	Stopsound           = 16, // <see code>
	NQUpdatecolors     = 17, // [byte] [byte] [byte]
	NQParticle         = 18, // [vec3] <variable>
	Damage              = 19,
	Spawnstatic         = 20,
	Spawnbinary         = 21,
	Spawnbaseline       = 22,
	Tempentity         = 23, // variable
	Setpause            = 24, // [byte] on / off
	NQSignonnum        = 25, // [byte]  used for the signon sequence
	Centerprint         = 26, // [string] to put in center of the screen
	Killedmonster       = 27,
	Foundsecret         = 28,
	Spawnstaticsound    = 29, // [coord3] [byte] samp [byte] vol [byte] aten
	Intermission        = 30, // [vec3_t] origin [vec3_t] angle
	Finale              = 31, // [string] text
	Cdtrack             = 32, // [byte] track
	Sellscreen          = 33,
	//NQCutscene         = 34, // same as svc_smallkick
	Smallkick           = 34, // set client punchangle to 2
	Bigkick             = 35, // set client punchangle to 4
	Updateping          = 36, // [byte] [short]
	Updateentertime     = 37, // [byte] [float]
	Updatestatlong      = 38, // [byte] [long]
	Muzzleflash         = 39, // [short] entity
	Updateuserinfo      = 40, // [byte] slot [long] uid [string] userinfo
	Download            = 41, // [short] size [size bytes]
	Playerinfo          = 42, // variable
	Nails               = 43, // [byte] num [48 bits] xyzpy 12 12 12 4 8
	Chokecount          = 44, // [byte] packets choked
	Modellist           = 45, // [strings]
	Soundlist           = 46, // [strings]
	Packetentities      = 47, // [...]
	Deltapacketentities = 48, // [...]
	Maxspeed            = 49, // maxspeed change, for prediction
	Entgravity          = 50, // gravity change, for prediction
	Setinfo             = 51, // setinfo on a client
	Serverinfo          = 52, // serverinfo
	Updatepl            = 53, // [byte] [byte]
	Nails2              = 54,
	FteModellistshort  = 60,
	FteSpawnbaseline2  = 66,
	Qizmovoice          = 83,
};

struct packet_s {
    u32 size;
    if (size == 0)
        break;
    MessageType type;
    u8 data[size-1];
};


struct frame_s
{
    u8 demo_time [[comment("demo command")]];
    u8 command [[comment("demo command")]];
    if (command & 7 == 3) {
        u32 multiple_to;
    } else if (command & 7 == 2){
        u32 incoming_sequence;
        u32 outgoing_sequence;
    }
    packet_s packet[];
};

struct signature_s {
    frame_s frame[10];
};



signature_s signature @ 0x00 [[comment("MVD file signature"), name("Signature")]];
