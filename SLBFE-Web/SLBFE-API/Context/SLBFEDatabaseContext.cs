using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using SLBFE_API.Models;

namespace SLBFE_API.Context
{
    public partial class SLBFEDatabaseContext : DbContext
    {
        public SLBFEDatabaseContext()
        {
        }

        public SLBFEDatabaseContext(DbContextOptions<SLBFEDatabaseContext> options)
            : base(options)
        {
        }

        public virtual DbSet<BoUser> BoUsers { get; set; } = null!;
        public virtual DbSet<FcUser> FcUsers { get; set; } = null!;
        public virtual DbSet<JsComplain> JsComplains { get; set; } = null!;
        public virtual DbSet<JsContact> JsContacts { get; set; } = null!;
        public virtual DbSet<JsDocument> JsDocuments { get; set; } = null!;
        public virtual DbSet<JsQualification> JsQualifications { get; set; } = null!;
        public virtual DbSet<JsUser> JsUsers { get; set; } = null!;
        public virtual DbSet<JsUsersArchive> JsUsersArchives { get; set; } = null!;
        public virtual DbSet<JsUsersJsQualification> JsUsersJsQualifications { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Server=tcp:ddhprr-cw.database.windows.net,1433;Initial Catalog=SLBFE-Database;Persist Security Info=False;User ID=fygcsadmin;Password=nsbmPly!);MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BoUser>(entity =>
            {
                entity.HasKey(e => e.Email)
                    .HasName("PK__BO_USERS__A9D105355AAE18BF");

                entity.ToTable("BO_USERS");

                entity.Property(e => e.Email)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Name)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Password)
                    .HasMaxLength(200)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<FcUser>(entity =>
            {
                entity.HasKey(e => e.Fcid)
                    .HasName("PK__FC_USERS__906B021F5C4CEBA2");

                entity.ToTable("FC_USERS");

                entity.Property(e => e.Fcid).HasColumnName("FCID");

                entity.Property(e => e.CompanyName)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Email)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Name)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Password)
                    .HasMaxLength(200)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<JsComplain>(entity =>
            {
                entity.HasKey(e => e.ComplaintId)
                    .HasName("PK__JS_COMPL__740D89AFC2832CB8");

                entity.ToTable("JS_COMPLAINS");

                entity.Property(e => e.ComplaintId).HasColumnName("ComplaintID");

                entity.Property(e => e.Complain)
                    .HasMaxLength(1000)
                    .IsUnicode(false);

                entity.Property(e => e.Feedback)
                    .HasMaxLength(1000)
                    .IsUnicode(false);

                entity.Property(e => e.JsNic).HasColumnName("JS_NIC");

                /*entity.HasOne(d => d.JsNicNavigation)
                    .WithMany(p => p.JsComplains)
                    .HasForeignKey(d => d.JsNic)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__JS_COMPLA__JS_NI__151B244E");*/
            });

            modelBuilder.Entity<JsContact>(entity =>
            {
                entity.HasKey(e => e.ContactId)
                    .HasName("PK__JS_CONTA__5C6625BB48C4B6CB");

                entity.ToTable("JS_CONTACTS");

                entity.Property(e => e.ContactId).HasColumnName("ContactID");

                entity.Property(e => e.Emmergency)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.JsNic).HasColumnName("JS_NIC");

                entity.Property(e => e.Personal)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Work)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.HasOne(d => d.JsNicNavigation)
                    .WithMany(p => p.JsContacts)
                    .HasForeignKey(d => d.JsNic)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__JS_CONTAC__JS_NI__0C85DE4D");
            });

            modelBuilder.Entity<JsDocument>(entity =>
            {
                entity.HasKey(e => e.DocId)
                    .HasName("PK__JS_DOCUM__3EF1888D2BAFD9F5");

                entity.ToTable("JS_DOCUMENTS");

                entity.Property(e => e.DocId).HasColumnName("DocID");

                entity.Property(e => e.Alevel)
                    .HasMaxLength(500)
                    .IsUnicode(false)
                    .HasColumnName("ALevel");

                entity.Property(e => e.BirthCertificate)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.Cv)
                    .HasMaxLength(500)
                    .IsUnicode(false)
                    .HasColumnName("CV");

                entity.Property(e => e.Degree)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.DrivingLicence)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.JsNic).HasColumnName("JS_NIC");

                entity.Property(e => e.Olevel)
                    .HasMaxLength(500)
                    .IsUnicode(false)
                    .HasColumnName("OLevel");

                entity.Property(e => e.Passport)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.VaccineCard)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.HasOne(d => d.JsNicNavigation)
                    .WithMany(p => p.JsDocuments)
                    .HasForeignKey(d => d.JsNic)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__JS_DOCUME__JS_NI__0F624AF8");
            });

            modelBuilder.Entity<JsQualification>(entity =>
            {
                entity.HasKey(e => e.QualificationId)
                    .HasName("PK__JS_QUALI__C95C128A7B8F0C3E");

                entity.ToTable("JS_QUALIFICATIONS");

                entity.Property(e => e.QualificationId).HasColumnName("QualificationID");

                entity.Property(e => e.Alstatus).HasColumnName("ALStatus");

                entity.Property(e => e.DegreeField)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.JsNic).HasColumnName("JS_NIC");

                entity.Property(e => e.Olstatus).HasColumnName("OLStatus");

                entity.HasOne(d => d.JsNicNavigation)
                    .WithMany(p => p.JsQualifications)
                    .HasForeignKey(d => d.JsNic)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__JS_QUALIF__JS_NI__123EB7A3");
            });

            modelBuilder.Entity<JsUser>(entity =>
            {
                entity.HasKey(e => e.Nic)
                    .HasName("PK__JS_USERS__C7DEC332A6299538");

                entity.ToTable("JS_USERS");

                entity.Property(e => e.Nic)
                    .ValueGeneratedNever()
                    .HasColumnName("NIC");

                entity.Property(e => e.Address)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Affiliation)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Dob)
                    .HasColumnType("date")
                    .HasColumnName("DOB");

                entity.Property(e => e.Email)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.FirstName)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Gender)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.LastName)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.MaritalStatus)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Nationality)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Password)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Profession)
                    .HasMaxLength(200)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<JsUsersArchive>(entity =>
            {
                entity.HasKey(e => e.ArchiveId)
                    .HasName("PK__JS_USERS__33A73E7718E705EF");

                entity.ToTable("JS_USERS_ARCHIVES");

                entity.Property(e => e.ArchiveId).HasColumnName("ArchiveID");

                entity.Property(e => e.Address)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Affiliation)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Dob)
                    .HasColumnType("date")
                    .HasColumnName("DOB");

                entity.Property(e => e.Email)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.FirstName)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Gender)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.LastName)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.MaritalStatus)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Nationality)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Nic).HasColumnName("NIC");

                entity.Property(e => e.Password)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Profession)
                    .HasMaxLength(200)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<JsUsersJsQualification>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("JS_USERS JS_QUALIFICATIONS");

                entity.Property(e => e.Address)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Affiliation)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Alstatus).HasColumnName("ALStatus");

                entity.Property(e => e.DegreeField)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Dob)
                    .HasColumnType("date")
                    .HasColumnName("DOB");

                entity.Property(e => e.Email)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.FirstName)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Gender)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.JsNic).HasColumnName("JS_NIC");

                entity.Property(e => e.LastName)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.MaritalStatus)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Nationality)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Nic).HasColumnName("NIC");

                entity.Property(e => e.Olstatus).HasColumnName("OLStatus");

                entity.Property(e => e.Password)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.Profession)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.Property(e => e.QualificationId).HasColumnName("QualificationID");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("User");

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.Property(e => e.Name)
                    .HasMaxLength(10)
                    .IsFixedLength();
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
