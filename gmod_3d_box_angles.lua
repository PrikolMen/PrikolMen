-- Basic stuff
local vec_zero, ang_zero = Vector(), Angle()
local white, black = Color( 255, 255, 255 ), Color( 0, 0, 0 )

local ENT = {}
ENT.Type = "anim"
ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel( "models/hunter/blocks/cube075x075x025.mdl" )

    if (SERVER) then
        self:PhysicsInit( SOLID_VPHYSICS )
        self:DrawShadow( false )
    end

    self.Angle = Angle()
end

-- Box Sizes ( place your here :) )
ENT.Mins = Vector( -50, -25, -10)
ENT.Maxs = Vector( 50, 25, 30 )

-- Angle [y] update
function ENT:Think()
    self.Angle = Angle( 0, math.sin( CurTime() / 2) * 90 )
end

function ENT:Draw()
    -- Entity pos * angle
    local pos, ang = self:GetPos(), self:GetAngles()

    -- Magical converting for angle changes
    local mip = LocalToWorld( self.Mins, Angle(), pos, self.Angle )
    local map = LocalToWorld( self.Maxs, Angle(), pos, self.Angle )

    -- Beautiful text
    local tpos, tang = LocalToWorld( vec_zero, Angle( 0, 90, 90 ), pos, ang )
    cam.Start3D2D( Vector( pos[1], mip[2], pos[3] ), tang, math.Clamp( math.abs( self.Angle[2] / 90 ), 0.2, 0.5 ) )
        draw.SimpleText( tostring( self.Angle ), "Default", 0, 0, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    cam.End3D2D()

    -- Central "clock" lines
    render.DrawLine( pos, mip, black )
    render.DrawLine( pos, map, white )

    -- Yay color!!!11
    local color = self.Angle[2] > 0 and white or black

    -- Box of lines
    render.DrawLine( Vector( mip[1], mip[2], mip[3] ), Vector( mip[1], mip[2], map[3] ), color )
    render.DrawLine( Vector( mip[1], mip[2], mip[3] ), Vector( map[1], mip[2], mip[3] ), color )
    render.DrawLine( Vector( mip[1], mip[2], mip[3] ), Vector( mip[1], map[2], mip[3] ), color )

    render.DrawLine( Vector( map[1], map[2], mip[3] ), Vector( map[1], map[2], map[3] ), color )
    render.DrawLine( Vector( map[1], map[2], mip[3] ), Vector( mip[1], map[2], mip[3] ), color )
    render.DrawLine( Vector( map[1], map[2], mip[3] ), Vector( map[1], mip[2], mip[3] ), color )

    render.DrawLine( Vector( map[1], mip[2], mip[3] ), Vector( map[1], mip[2], map[3] ), color )
    render.DrawLine( Vector( map[1], map[2], map[3] ), Vector( map[1], mip[2], map[3] ), color )
    render.DrawLine( Vector( mip[1], mip[2], map[3] ), Vector( map[1], mip[2], map[3] ), color )

    render.DrawLine( Vector( mip[1], map[2], mip[3] ), Vector( mip[1], map[2], map[3] ), color )
    render.DrawLine( Vector( map[1], map[2], map[3] ), Vector( mip[1], map[2], map[3] ), color )
    render.DrawLine( Vector( mip[1], map[2], map[3] ), Vector( mip[1], mip[2], map[3] ), color )
end

scripted_ents.Register( ENT, "3d_box_angles" )
