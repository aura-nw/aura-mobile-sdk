// This file was generated by a tool; you should avoid making direct changes.
// Consider using 'partial classes' to extend these types
// Input: http.proto

#pragma warning disable CS0612, CS1591, CS3021, IDE1006, RCS1036, RCS1057, RCS1085, RCS1192
namespace google.api
{

    [global::ProtoBuf.ProtoContract()]
    public partial class Http : global::ProtoBuf.IExtensible
    {
        private global::ProtoBuf.IExtension __pbn__extensionData;
        global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
            => global::ProtoBuf.Extensible.GetExtensionObject(ref __pbn__extensionData, createIfMissing);

        [global::ProtoBuf.ProtoMember(1, Name = @"rules")]
        public global::System.Collections.Generic.List<HttpRule> Rules { get; } = new global::System.Collections.Generic.List<HttpRule>();

        [global::ProtoBuf.ProtoMember(2, Name = @"fully_decode_reserved_expansion")]
        public bool FullyDecodeReservedExpansion { get; set; }

    }

    [global::ProtoBuf.ProtoContract()]
    public partial class HttpRule : global::ProtoBuf.IExtensible
    {
        private global::ProtoBuf.IExtension __pbn__extensionData;
        global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
            => global::ProtoBuf.Extensible.GetExtensionObject(ref __pbn__extensionData, createIfMissing);

        [global::ProtoBuf.ProtoMember(1, Name = @"selector")]
        [global::System.ComponentModel.DefaultValue("")]
        public string Selector { get; set; } = "";

        [global::ProtoBuf.ProtoMember(2, Name = @"get")]
        [global::System.ComponentModel.DefaultValue("")]
        public string Get
        {
            get { return __pbn__pattern.Is(2) ? ((string)__pbn__pattern.Object) : ""; }
            set { __pbn__pattern = new global::ProtoBuf.DiscriminatedUnionObject(2, value); }
        }
        public bool ShouldSerializeGet() => __pbn__pattern.Is(2);
        public void ResetGet() => global::ProtoBuf.DiscriminatedUnionObject.Reset(ref __pbn__pattern, 2);

        private global::ProtoBuf.DiscriminatedUnionObject __pbn__pattern;

        [global::ProtoBuf.ProtoMember(3, Name = @"put")]
        [global::System.ComponentModel.DefaultValue("")]
        public string Put
        {
            get { return __pbn__pattern.Is(3) ? ((string)__pbn__pattern.Object) : ""; }
            set { __pbn__pattern = new global::ProtoBuf.DiscriminatedUnionObject(3, value); }
        }
        public bool ShouldSerializePut() => __pbn__pattern.Is(3);
        public void ResetPut() => global::ProtoBuf.DiscriminatedUnionObject.Reset(ref __pbn__pattern, 3);

        [global::ProtoBuf.ProtoMember(4, Name = @"post")]
        [global::System.ComponentModel.DefaultValue("")]
        public string Post
        {
            get { return __pbn__pattern.Is(4) ? ((string)__pbn__pattern.Object) : ""; }
            set { __pbn__pattern = new global::ProtoBuf.DiscriminatedUnionObject(4, value); }
        }
        public bool ShouldSerializePost() => __pbn__pattern.Is(4);
        public void ResetPost() => global::ProtoBuf.DiscriminatedUnionObject.Reset(ref __pbn__pattern, 4);

        [global::ProtoBuf.ProtoMember(5, Name = @"delete")]
        [global::System.ComponentModel.DefaultValue("")]
        public string Delete
        {
            get { return __pbn__pattern.Is(5) ? ((string)__pbn__pattern.Object) : ""; }
            set { __pbn__pattern = new global::ProtoBuf.DiscriminatedUnionObject(5, value); }
        }
        public bool ShouldSerializeDelete() => __pbn__pattern.Is(5);
        public void ResetDelete() => global::ProtoBuf.DiscriminatedUnionObject.Reset(ref __pbn__pattern, 5);

        [global::ProtoBuf.ProtoMember(6, Name = @"patch")]
        [global::System.ComponentModel.DefaultValue("")]
        public string Patch
        {
            get { return __pbn__pattern.Is(6) ? ((string)__pbn__pattern.Object) : ""; }
            set { __pbn__pattern = new global::ProtoBuf.DiscriminatedUnionObject(6, value); }
        }
        public bool ShouldSerializePatch() => __pbn__pattern.Is(6);
        public void ResetPatch() => global::ProtoBuf.DiscriminatedUnionObject.Reset(ref __pbn__pattern, 6);

        [global::ProtoBuf.ProtoMember(8, Name = @"custom")]
        public CustomHttpPattern Custom
        {
            get { return __pbn__pattern.Is(8) ? ((CustomHttpPattern)__pbn__pattern.Object) : default; }
            set { __pbn__pattern = new global::ProtoBuf.DiscriminatedUnionObject(8, value); }
        }
        public bool ShouldSerializeCustom() => __pbn__pattern.Is(8);
        public void ResetCustom() => global::ProtoBuf.DiscriminatedUnionObject.Reset(ref __pbn__pattern, 8);

        [global::ProtoBuf.ProtoMember(7, Name = @"body")]
        [global::System.ComponentModel.DefaultValue("")]
        public string Body { get; set; } = "";

        [global::ProtoBuf.ProtoMember(12, Name = @"response_body")]
        [global::System.ComponentModel.DefaultValue("")]
        public string ResponseBody { get; set; } = "";

        [global::ProtoBuf.ProtoMember(11, Name = @"additional_bindings")]
        public global::System.Collections.Generic.List<HttpRule> AdditionalBindings { get; } = new global::System.Collections.Generic.List<HttpRule>();

    }

    [global::ProtoBuf.ProtoContract()]
    public partial class CustomHttpPattern : global::ProtoBuf.IExtensible
    {
        private global::ProtoBuf.IExtension __pbn__extensionData;
        global::ProtoBuf.IExtension global::ProtoBuf.IExtensible.GetExtensionObject(bool createIfMissing)
            => global::ProtoBuf.Extensible.GetExtensionObject(ref __pbn__extensionData, createIfMissing);

        [global::ProtoBuf.ProtoMember(1, Name = @"kind")]
        [global::System.ComponentModel.DefaultValue("")]
        public string Kind { get; set; } = "";

        [global::ProtoBuf.ProtoMember(2, Name = @"path")]
        [global::System.ComponentModel.DefaultValue("")]
        public string Path { get; set; } = "";

    }

}

#pragma warning restore CS0612, CS1591, CS3021, IDE1006, RCS1036, RCS1057, RCS1085, RCS1192
