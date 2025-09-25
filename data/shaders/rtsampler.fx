sampler DiffSampler = sampler_state
{
    Texture = <DiffMap0>;
/*    AddressU  = Wrap;
    AddressV  = Wrap;*/
    AddressU  = Clamp;
    AddressV  = Clamp;
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Point;
};
